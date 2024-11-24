import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/article.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:mobdeve_mco/models/user.dart';

class ListController extends GetxController{
  static ListController get instance => Get.find();

  // Use this stream to get the list of lists of user
  Rx<List<ListModel>> currentUserLists = Rx<List<ListModel>>([]);
// Maybe we can make a stream? but make the stream only for the current user


  
  static Stream<List<ListModel>> currentUserListStream() {
    final controller = StreamController<List<ListModel>>();
    UserController.instance.currentUser.stream.listen((currentUser) {
      if (currentUser == null) {
        controller.add([]);
      } else {
        firebaseFirestore
            .collection('users')
            .doc(currentUser.id)
            .collection('lists')
            .snapshots()
            .listen((snapshot) {
              // Map snapshot document
              final listModels = snapshot.docs.map((list) {
                final listModel = ListModel.fromDocumentSnapshot(documentSnapshot: list);
                print('ListModel for User: ${listModel.id}');
                return listModel;
              }).toList();
              controller.add(listModels);
        });
      }
    });
  
    return controller.stream;
  }

  // Create List
  Future<void> createListForCurrentUser(String listTitle, String listDescription) async {
    String? currentUserId = UserController.instance.currentUser.value?.id;
    if (currentUserId == null){
      throw Exception("Error creating List, current user is null");
    }

    await firebaseFirestore.collection('users').doc(currentUserId).collection('lists').add({
      'articlesBookmarked': [],
      'authorId': currentUserId,
      'title': listTitle,
      'description': listDescription,
    });
  }
  // Edit List
  Future<void> editListOfUser(ListModel listToEdit) async {
    // This also assumes that the id found in list parameter corresponds to the list to edit
    // It also assumes that you are editing the list of the current user
    // Make sure use is logged in
    String? currentUserId = UserController.instance.currentUser.value?.id;
    if (currentUserId == null){
      throw Exception("Error editing List, current user is null");
    }
    final documentRef = firebaseFirestore.collection('users').doc(currentUserId).collection('lists').doc(listToEdit.id);
    
    // Check if document exists first, if not throw an error:
    DocumentSnapshot documentSnapshot = await documentRef.get();
    if(!documentSnapshot.exists){
      throw Exception("Error editing list, List ID not found");
    }

    // Since it exists, we edit the title and description
    await documentRef.update({
      'title': listToEdit.title,
      'description': listToEdit.description,
    });
  }
  // Delete List 
  Future<void> deleteListOfUser(ListModel listToDelete) async {
    String? currentUserId = UserController.instance.currentUser.value?.id;
    if(currentUserId == null){
      throw Exception("Error deleting List, current user is null");
    }
    final documentRef = firebaseFirestore.collection('users').doc(currentUserId).collection('lists').doc(listToDelete.id);
    
    // Check if document exists first, if not throw an error:
    DocumentSnapshot documentSnapshot = await documentRef.get();
    if(!documentSnapshot.exists){
      throw Exception("Error deleting list, List ID not found");
    }
    await documentRef.delete();
  }
  // Delete from List
  Future<void> deleteArticleFromList(ListModel list, String article) async {
    // Given an article, we delete the list from a users List of lists. 
    String? currentUserId = UserController.instance.currentUser.value?.id;

    // Check if the user is logged in
    if(currentUserId == null){
      throw Exception("Error deleting article from list, current user is null");
    }
    // Check if this list is owned by the user 
    if(list.authorId != currentUserId){
      throw Exception("Error deleting article from list, list is not owned by user");
    }
    final documentRef = firebaseFirestore.collection('users').doc(currentUserId).collection('lists').doc(list.id);
    
    // Check if document exists first, if not throw an error:
    DocumentSnapshot documentSnapshot = await documentRef.get();
    if(!documentSnapshot.exists){
      throw Exception("Error deleting article from list, List ID not found");
    }
    // This is the collection
    ListModel listInCollection = ListModel.fromDocumentSnapshot(documentSnapshot: documentSnapshot);

    // If article was in the list, and was removed
    if(listInCollection.articleIds.remove(article)){
      await documentRef.update({
        'articlesBookmarked': listInCollection.articleIds,
      });
    } else {
      throw Exception("Error deleting article from list, article not found");
    }
  }


  Future<void> addArticleFromList(ListModel list, String article) async {
    // Given an article, we delete the list from a users List of lists. 
    String? currentUserId = UserController.instance.currentUser.value?.id;
    // Check if the user is logged in
    if(currentUserId == null){
      throw Exception("Error adding article to list, current user is null");
    }
    // Check if this list is owned by the user 
    if(list.authorId != currentUserId){
      throw Exception("Error adding article to list, list is not owned by user");
    }

    final documentRef = firebaseFirestore.collection('users').doc(currentUserId).collection('lists').doc(list.id);
    
    // Check if document exists first, if not throw an error:
    DocumentSnapshot documentSnapshot = await documentRef.get();
    if(!documentSnapshot.exists){
      throw Exception("Error adding article from list, List ID not found");
    }
    // This is the collection
    ListModel listInCollection = ListModel.fromDocumentSnapshot(documentSnapshot: documentSnapshot);

    if(listInCollection.articleIds.contains(article)){
      throw Exception("Error adding article to list, is already in the list");
    } else {
      listInCollection.articleIds.add(article);
      await documentRef.update({
        'articlesBookmarked': listInCollection.articleIds,
      });
    }
  }

  Future<List<Article>> getArticlesFromArticleArray(List<String> articleIds) async {
    try {
      if (articleIds.isEmpty) return [];
  
      // Use Firestore's whereIn clause to fetch all matching documents in a single query
      final querySnapshot = await firebaseFirestore
          .collection('articles')
          .where(FieldPath.documentId, whereIn: articleIds)
          .get();
  
      // Map each document into an Article object
      return querySnapshot.docs
          .map((doc) => Article.fromDocumentSnapshot(documentSnapshot: doc))
          .toList();
    } catch (e) {
      print('Error fetching articles: $e');
      rethrow;
    }
  }


  
  // Add Article to List
  @override
  void onReady() {
    currentUserLists.bindStream(currentUserListStream());
  }
}
