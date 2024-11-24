import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

class ListModel{
  String? id;
  late String authorId;
  late String title;
  late String description;
  // This stores the ID
  late List<String> articleIds;

  ListModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.articleIds,
  });

  ListModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    title = documentSnapshot[TITLE];
    description = documentSnapshot['description'];
    authorId = documentSnapshot['authorId'];    
    articleIds = List<String>.from(documentSnapshot['articlesBookmarked'] as List);
  }
}
