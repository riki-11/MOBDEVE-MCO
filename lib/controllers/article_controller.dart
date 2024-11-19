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

            final userSnapshot = await firebaseFirestore
              .collection('users')
              .doc(article[AUTHOR_ID])
              .get();
            articleModel.author = User.fromDocumentSnapshot(documentSnapshot: userSnapshot);
            final programSnapshot = await firebaseFirestore
              .collection('programs')
              .doc(article[PROGRAM])
              .get();
            articleModel.program = Program.fromDocumentSnapshot(documentSnapshot: programSnapshot);
            final collegeSnapshot = await firebaseFirestore
              .collection('colleges')
              .doc(article[COLLEGE])
              .get();
            articleModel.college = College.fromDocumentSnapshot(documentSnapshot: collegeSnapshot);
            articleModel.program.college = articleModel.college;
            articles.add(articleModel);
          }
          return articles;
    });
  }
  @override
  void onReady() {
    articleList.bindStream(articleStream());
  }
}
