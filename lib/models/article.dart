import 'package:mobdeve_mco/models/program.dart';
import 'college.dart';

class Article {
  String id;
  String authorId;
  String title;
  String content;
  DateTime datePosted;
  College college;
  Program program;
  Article({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.datePosted,
    required this.college,
    required this.program,
  });
  // Reaction reactions;
  // Comments
  // Colleges Tag
  // Programs Tag
}
