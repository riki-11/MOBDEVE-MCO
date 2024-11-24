import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobdeve_mco/models/program.dart';
import 'package:mobdeve_mco/models/user.dart';
import '../constants/global_consts.dart';
import 'college.dart';

class Article {
  String? id;
  late String authorId;
  late String title;
  late Map<String, String> content;
  late Timestamp datePosted;
  late String collegeId;
  late String programId;
  late bool isPublished;

  Article({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.datePosted,
    required this.collegeId,
    required this.programId,
    required this.isPublished
  });

  Article.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    title = documentSnapshot[TITLE];
    content = Map<String, String>.from(documentSnapshot[CONTENT] as Map);
    datePosted = documentSnapshot[DATE_POSTED];
    collegeId = documentSnapshot[COLLEGE_ID];
    programId = documentSnapshot[PROGRAM_ID];
    authorId = documentSnapshot[AUTHOR_ID];
    // Check if the field exists, default to true if not
    try{
      isPublished = documentSnapshot['isPublished'];
    } catch (e) {
      print('Error with isPublished, setting to true. Error: $e');
      isPublished = true;
    }
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
