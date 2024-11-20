import 'package:get/get.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  Future <void> registerUserToFirestore(String email, String firstName, String lastName) async {
    // TODO: Add college and course here
    await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  // TODO: implement user being generated if they're not found, then reset?

}
