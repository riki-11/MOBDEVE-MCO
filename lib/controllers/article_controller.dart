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
        'authorId': article.authorId,
        'title': article.title,
        'content': article.content,
        'datePosted': article.datePosted,
        'collegeId': article.collegeId,
        'programId': article.programId,
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
