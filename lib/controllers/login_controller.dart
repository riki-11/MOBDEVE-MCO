
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password){
     AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  }
  void logoutUser(){
    AuthenticationRepository.instance.logout();
  }

  Future<void> checkUserInCloudFirestore() async {
    var user = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get(); 

    if(!user.exists){
      // Delete auth of user, and push him to logout
      var userToDelete = auth.currentUser;
      userToDelete?.delete();
      logoutUser();
    }
  }
}

