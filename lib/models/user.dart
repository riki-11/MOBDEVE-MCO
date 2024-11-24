import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  late String email;
  late String firstName;
  late String lastName;
  late String colleges;
  late String programs;
  late List<String> lists;

  User(
      {required this.id,
      required this.email,
      required this.lastName,
      required this.firstName,
      required this.colleges,
      required this.programs});

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot['email'];
    firstName = documentSnapshot['firstName'];
    lastName = documentSnapshot['lastName'];
    colleges = documentSnapshot['college'];
    programs = documentSnapshot['program'];
  }

  String getName() {
    return "$firstName $lastName";
  }
}
