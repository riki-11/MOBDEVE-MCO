import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
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
    if (currentUserId == null){
      throw Exception("Error creating List, current user is null");
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

  // Add Article to List
  @override
  void onReady() {
    currentUserLists.bindStream(currentUserListStream());
  }
}
