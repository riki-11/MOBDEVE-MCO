import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/models/article.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

import '../models/college.dart';
import '../models/program.dart';
import '../models/user.dart';

class ArticleController extends GetxController{
  static ArticleController get instance => Get.find();
  Rx<List<Article>> articleList = Rx<List<Article>>([]);
  List<Article> get articles => articleList.value;

  Rxn<College> collegeFilter = Rxn<College>();
  Rxn<Program> programFilter = Rxn<Program>(); 

  Rx<bool> isFilterVisible = Rx<bool>(false);
  void toggleFilter(bool isFilterVisible){
    this.isFilterVisible.value = isFilterVisible;
  }
  static Stream<List<Article>> articleStream() {
    return firebaseFirestore.collection('articles')
        .snapshots()
        .asyncMap((QuerySnapshot query) async {
          List<Article> articles = [];
          for (var article in query.docs) {
            final articleModel =
                Article.fromDocumentSnapshot(documentSnapshot: article);
            articles.add(articleModel);
          }
          return articles;
    });
  }

  Future<void> addArticle(Article article) async {
    try {
      // Map the article to a Firestore-compatible format
      Map<String, dynamic> articleData = {
        AUTHOR_ID: article.authorId,
        TITLE: article.title,
        CONTENT: article.content,
        DATE_POSTED: article.datePosted,
        COLLEGE_ID: article.collegeId,
        PROGRAM_ID: article.programId,
      };


      // Add the article to the "articles" collection
      await firebaseFirestore.collection('articles').add(articleData);

      print('Article added successfully!');
    } catch (e) {
      print('Failed to add article: $e');
      rethrow;
    }
  }





  @override
  void onReady() {
    articleList.bindStream(articleStream());
  }
}
