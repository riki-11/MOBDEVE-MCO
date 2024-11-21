import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';

import '../models/college.dart';

class CollegeController extends GetxController {
  static CollegeController get instance => Get.find();

  Rx<List<College>> collegeList = Rx<List<College>>([]);
  static final collegeCollection = firebaseFirestore.collection('colleges');
  static Stream<List<College>> collegeStream() {
    return collegeCollection.snapshots().map((QuerySnapshot query) {
      List<College> colleges = [];
      for (var college in query.docs) {
        final collegeModel =
            College.fromDocumentSnapshot(documentSnapshot: college);
        colleges.add(collegeModel);
      }
      return colleges;
    });
  }

  // Future<void> fetchColleges() async{
  //   var collegeList = await getCollegeList();
  //   this.collegeList.value = collegeList;
  // }
  //
  // Future<List<College>> getCollegeList() async{
  //   var querySnapshot = await firebaseFirestore.collection(COLLEGE).get();
  //   List<College> collegeList = querySnapshot.docs.map((college) {
  //     return College.fromDocumentSnapshot(documentSnapshot: college);
  //   }).toList();
  //   return collegeList;
  // }
  Future<College> getCollege(String documentId) async {
    DocumentSnapshot college = await collegeCollection.doc(documentId).get();
    return College.fromDocumentSnapshot(documentSnapshot: college);
  }

  @override
  void onReady() {
    collegeList.bindStream(collegeStream());
  }
}
