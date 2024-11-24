import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/models/article.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

import '../models/college.dart';
import '../models/program.dart';

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

  Future<String> addArticle(Article article) async {
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
      DocumentReference docRef = await firebaseFirestore.collection('articles').add(articleData);
      print('Article added successfully!');
      return docRef.id;
    } catch (e) {
      print('Failed to add article: $e');
      rethrow;
    }
  }

  Future<void> updateArticle(String articleId, Article updatedArticle) async {
    try {

      Map<String, dynamic> updatedData = {
        AUTHOR_ID: updatedArticle.authorId,
        TITLE: updatedArticle.title,
        CONTENT: updatedArticle.content,
        DATE_POSTED: updatedArticle.datePosted,
        COLLEGE_ID: updatedArticle.collegeId,
        PROGRAM_ID: updatedArticle.programId,
      };

      // Update the article in the "articles" collection
      await firebaseFirestore.collection('articles').doc(articleId).update(updatedData);

      print('Article updated successfully!');
    } catch (e) {
      print('Failed to update article: $e');
      rethrow;
    }
  }

  Future<void> deleteArticle(String articleId) async {
    try {
      await firebaseFirestore.collection('articles').doc(articleId).delete();
      print('Successfully deleted article!');
    } catch (e) {
      print('Failed to delete article: $e');
      rethrow;
    }
  }

  Future<void> setPublishedOfArticle(Article articleToEdit, bool isPublished) async {
    try{
    await firebaseFirestore.collection('articles').doc(articleToEdit.id).update({
      'isPublished': isPublished
    });
    } catch (e) {
      print('Failed to set publish article: $e');
    }
  }

  @override
  void onReady() {
    articleList.bindStream(articleStream());
  }
}
