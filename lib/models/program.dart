import 'college.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Program {
  String? id;
  late String name;
  late String acronym;
  late College college;

  Program({
    required this.id,
    required this.name,
    required this.acronym,
    required this.college,
  });

  Program.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    acronym = documentSnapshot['acronym'];
  }

  static defaultInstance() {
    return Program(
      id: 'LOL',
      name: 'LOL',
      acronym: 'LOL', college: College.defaultInstance(),
    );
  }
}