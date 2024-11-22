import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:mobdeve_mco/models/user.dart';

class ListController extends GetxController{
  static ListController get instance => Get.find();

  Rxn<ListModel> currentUserList = Rxn<ListModel>();
  // Maybe we can make a stream? but make the stream only for the current user

  static Stream<ListModel?> currentUserListStream() {
    final controller = StreamController<ListModel?>();
    UserController.instance.currentUser.stream.listen((currentUser) {
      // Cancel previous subscriptions if needed (not shown here for simplicity)
      if (currentUser == null) {
        controller.add(null);
      } else {
        firebaseFirestore
            .collection('lists')
            .doc(currentUser.id)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            final listModel = ListModel.fromDocumentSnapshot(documentSnapshot: snapshot);
            print("CURRENT STREAM LISTMODEL ID: ${listModel.id}");
            controller.add(listModel);
          } else {
            controller.add(null);
          }
        });
      }
    });
  
    return controller.stream;
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
