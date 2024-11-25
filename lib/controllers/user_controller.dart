import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/controllers/college_controller.dart';
import 'package:mobdeve_mco/controllers/program_controller.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/pages/view-college-list.dart';

import '../models/college.dart';
import '../models/program.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  var currentUser = Rxn<User>();
  var currentUserCollege = Rxn<College>();
  var currentUserProgram = Rxn<Program>();
  Future<void> loadCurrentUser() async {
    final authRepo = AuthenticationRepository.instance;

    // Listens to Firebase Auth user
    authRepo.firebaseUser.listen((user) async {
      if (user != null) {
        try {
          final userSnapshot =
          await firebaseFirestore.collection('users').doc(user.uid).get();
          if (userSnapshot.exists) {
            currentUser.value =
                User.fromDocumentSnapshot(documentSnapshot: userSnapshot);
            if(currentUser.value?.colleges != null) {
              currentUserCollege.value = await CollegeController.instance.getCollege(currentUser.value!.colleges);
            }
            if(currentUser.value?.colleges != null){
              currentUserProgram.value = await ProgramController.instance.getProgram(currentUser.value!.programs);
            }
          } else {
            print("User document not found in Firestore for UID: ${user.uid}");
          }
        } catch (e) {
          print("Error loading user: $e");
        }
      } else {
        currentUser.value = null; // Reset when user logs out
      }
    });
  }

  Future<User> getUserData(String userId) async {
    final userSnapshot =
        await firebaseFirestore.collection('users').doc(userId).get();
    final user = User.fromDocumentSnapshot(documentSnapshot: userSnapshot);
    return user;
  }

  Future<void> assignCollegeAndProgram(
      String collegeId, String programId) async {
    final userDocRef =
        firebaseFirestore.collection('users').doc(auth.currentUser!.uid);

    try {
      // Update the user's document with collegeId and programId
      await userDocRef.update({
        'college': collegeId,
        'program': programId,
      });
      final updatedUserSnapshot = await userDocRef.get();
      currentUser.value = User.fromDocumentSnapshot(documentSnapshot: updatedUserSnapshot);

      await refreshCollegeAndProgram();
      print("Successfully assigned college and program.");

    } catch (e) {
      print("Error assigning college and program: $e");

      // Handle cases where the user document does not exist
      if (e.toString().contains('NOT_FOUND')) {
        print("User document does not exist.");
      }
    }
    await refreshCollegeAndProgram();
  }

  Future<void> refreshCollegeAndProgram() async {
    if (currentUser.value?.colleges != null) {
      currentUserCollege.value = await CollegeController.instance.getCollege(currentUser.value!.colleges);
    } else {
      currentUserCollege.value = null;
    }

    if (currentUser.value?.programs != null) {
      currentUserProgram.value = await ProgramController.instance.getProgram(currentUser.value!.programs);
    } else {
      currentUserProgram.value = null;
    }
  }
  Future<void> checkIfAssignedCollege() async {
    final userSnapshot = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    // Check if the "college" field exists and is not null
    if (userSnapshot.exists && userSnapshot.data() != null) {
      var data = userSnapshot.data() as Map<String, dynamic>;
      var isAssignedCollege =
          data.containsKey('college') && data['college'] != null;
      if (!isAssignedCollege) Get.offAll(const ViewCollegeList());
    }
  }

  Future<void> registerUserToFirestore(
      String email, String firstName, String lastName) async {
    // TODO: Add college and course here
    await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });
    var documentSnapshot = await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).get();
    currentUser.value = User.fromDocumentSnapshot(documentSnapshot: documentSnapshot);
  }

  Future<void> updateCurrentUser(User updateUser) async {
    await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).update({
      'firstName': updateUser.firstName,
      'lastName': updateUser.lastName,
      'college': updateUser.colleges,
      'program': updateUser.programs,
    });
    if(currentUser.value == null){
      throw Exception("ERROR UPDATING USER: current user is null");
    }
    currentUser.value?.firstName = updateUser.firstName;
    currentUser.value?.lastName = updateUser.lastName;
    currentUser.value?.colleges = updateUser.colleges;
    currentUser.value?.programs = updateUser.programs;
    refreshCollegeAndProgram();
  }
}
