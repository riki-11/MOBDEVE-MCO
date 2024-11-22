import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:mobdeve_mco/models/user.dart';

class ListController extends GetxController{
  static ListController get instance => Get.find();

  Rx<List<ListModel>> currentUserList = Rx<List<ListModel>>([]);
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
    if (currentUserId != listToAdd.id){
      throw Exception("Error creating List, current user doesn't match ID found in list");
    }

    firebaseFirestore.collection('users').doc(currentUserId).collection('lists').add({
      'articleIds': [],
      'authorId': listToAdd.id,
      'title': listToAdd.title,
      'description': listToAdd.description,
    });

  }
  // Edit List

  // Delete List 

  // Delete from List

  // Add Article to List
  @override
  void onReady() {
    currentUserList.bindStream(currentUserListStream());
  }
}
