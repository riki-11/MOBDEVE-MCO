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
      // Cancel previous subscriptions if needed (not shown here for simplicity)
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

  // Generate List for user
  Future<void> generateListForCurrentUser(User user) async {
    firebaseFirestore.collection('lists').doc(user.id).set({
      'authorId': user.id,


    });
  }


  // Add List

  // Edit List

  // Delete List 

  // Delete from List

  // Add Article to List
  @override
  void onReady() {
    currentUserList.bindStream(currentUserListStream());
  }
}
