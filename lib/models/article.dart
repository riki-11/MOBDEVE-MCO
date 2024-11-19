import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobdeve_mco/models/program.dart';
import '../constants/global_consts.dart';
import 'college.dart';

class Article {
  String? id;
  late String authorId;
  late String title;
  late String content;
  late Timestamp datePosted;
  late College college;
  late Program program;
  Article({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.datePosted,
    required this.college,
    required this.program,
  });

  Article.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    authorId = documentSnapshot[AUTHOR_ID];
    title = documentSnapshot[TITLE];
    content = documentSnapshot[CONTENT];
    datePosted = documentSnapshot[DATE_POSTED];
    college =
        College(id: documentSnapshot[COLLEGE], name: "FOO", acronym: "FOO");
    program = Program(
        id: documentSnapshot[PROGRAM],
        name: 'FOO',
        acronym: 'FOO',
        college: college);
  }
  // factory Article.fromFirestore(Map<String, dynamic> data) {
  //   return Article(
  //     id: data[DOC_ID] ?? '',
  //     content: data[CONTENT] ?? '',
  //     authorId: data[AUTHOR_ID] ?? '',
  //     title: data[TITLE] ?? '',
  //     datePosted: data[DATE_POSTED] ?? '',
  //     college: data[COLLEGE] ?? '',
  //     program: data[PROGRAM] ?? '',
  //   );
  // Reaction reactions;
  // Comments
  // Colleges Tag
  // Programs Tag
  // }
}
