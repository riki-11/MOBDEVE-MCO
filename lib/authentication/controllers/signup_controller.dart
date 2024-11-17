import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/widgets/email_field_widget.dart';
import 'package:passwordfield/passwordfield.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void registerUser(String email, String password){
    
  }

}