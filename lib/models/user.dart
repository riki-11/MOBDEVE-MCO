import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  late String email;
  late String firstName;
  late String lastName;
  late String colleges;
  late List<String> programs;
  late List<String> lists;

  User(
      {required this.id,
      required this.email,
      required this.lastName,
      required this.firstName,
      required this.colleges,
      required this.lists,
      required this.programs});

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot['email'];
    firstName = documentSnapshot['firstName'];
    lastName = documentSnapshot['lastName'];
    colleges = documentSnapshot['colleges'];
    programs = List<String>.from(documentSnapshot['programs']);
    lists = List<String>.from(documentSnapshot['lists']);
  }
}
