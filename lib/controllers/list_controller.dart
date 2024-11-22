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
  Future<void> createListForCurrentUser(ListModel listToAdd) async {
    String? currentUserId = UserController.instance.currentUser.value?.id;
    if (currentUserId == null){
      throw Exception("Error creating List, current user is null");
    }

    await firebaseFirestore.collection('users').doc(currentUserId).collection('lists').add({
      'articleIds': [],
      'authorId': listToAdd.id,
      'title': listToAdd.title,
      'description': listToAdd.description,
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
    await documentRef.set({
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
  Future<void> deleteArticleFromList(ListModel list, Article article) async {
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
    if(listInCollection.articlesBookmarked.remove(article.id)){
      await documentRef.set({
        'articlesBookmarked': listInCollection.articlesBookmarked,
      });
    } else {
      throw Exception("Error deleting article from list, article not found");
    }
    
  }
  // Add Article to List
  @override
  void onReady() {
    currentUserLists.bindStream(currentUserListStream());
  }
}
