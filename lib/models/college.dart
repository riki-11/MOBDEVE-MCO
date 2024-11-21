import 'package:cloud_firestore/cloud_firestore.dart';

class College {
  String? id;
  late String name;
  late String acronym;

  College({
    required this.id,
    required this.name,
    required this.acronym,
  });

  College.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    acronym = documentSnapshot['acronym'];
  }

  static College defaultInstance() {
    return College(
      id: '-1',
      name: 'Jeff',
      acronym: 'JEFF',
    );
  }
}
