import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/models/program.dart';

import '../models/college.dart';

class ProgramController extends GetxController {
  static ProgramController get instance => Get.find();

  Rx<List<Program>> programList = Rx<List<Program>>([]);
  static final programCollection = firebaseFirestore.collection('programs');
  static Stream<List<Program>> programStream() {
    return programCollection.snapshots().asyncMap((QuerySnapshot query) async {
      List<Program> programs = [];
      try{
      for (var program in query.docs) {

        final programModel =
            Program.fromDocumentSnapshot(documentSnapshot: program);
        final collegeSnapshot = await firebaseFirestore
            .collection('colleges')
            .doc(program[COLLEGE_ID])
            .get();
        programModel.college = College.fromDocumentSnapshot(documentSnapshot: collegeSnapshot);
        programs.add(programModel);
      }} on Exception catch(e){
        print("EXCEPTION IN PROGRAM WAS THROWN");
        throw Exception(e);
      }
      return programs;
    });
  }

  Future<Program> getProgram(String programId) async{
    return Program.fromDocumentSnapshot(documentSnapshot: await programCollection.doc(programId).get());
  }

  List<Program> getProgramListFromCollege(String collegeId) {
    var specificPrograms = programList.value
        .where((program) => program.college.id == collegeId)
        .toList();
    for(var program in specificPrograms) print("PROGRAM COLLEGE IDs: ${program.college.id}");
    print("CALLED PROGRAM GET: list = $specificPrograms}, COLLEGE ID: ${collegeId}");
    return specificPrograms;
  }

  @override
  void onReady() {
    programList.bindStream(programStream());
  }
}
