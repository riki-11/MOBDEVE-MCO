import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

import '../models/reaction.dart';

class ReactionController extends GetxController{
  static ReactionController get instance => Get.find();
  static String REACTION_COLLECTION = 'reactions';

  static likePost(String articleId) async {
    Reaction newReaction = Reaction(userId: auth.currentUser!.uid, articleId: articleId);
    await firebaseFirestore.collection(REACTION_COLLECTION).doc(
      "${newReaction.userId}_${newReaction.articleId}"
    ).set({
      'articleId': newReaction.articleId,
      'userId': newReaction.userId,
    });
  }
  static Future<bool> isArticleLikedByUser(String articleId) async {
    String reactionDocId = '${auth.currentUser!.uid}_$articleId';
    var doc = await firebaseFirestore.collection(REACTION_COLLECTION)
        .doc(reactionDocId).get();

    return (doc.exists) ?  true : false;
  }
  static unlikePost(String articleId) async{
    Reaction newReaction = Reaction(userId: auth.currentUser!.uid, articleId: articleId);
    await firebaseFirestore.collection(REACTION_COLLECTION).doc(
        "${newReaction.userId}_${newReaction.articleId}"
    ).delete();
  }
  Future<int> getLikeCountOfArticle(String articleId) async {
    // TODO: get like count of article
    try{
      AggregateQuerySnapshot res = await firebaseFirestore
          .collection(REACTION_COLLECTION)
          .where("articleId", isEqualTo: articleId)
          .count()
          .get();

      return res.count ?? -1;
    } catch (e){
      print("Getting Like Count Error: $e");
      return -1;
    }


  }
  // void loginUser(String email, String password){
  //   AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  // }
}