import 'package:get/get.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/pages/view-college-list.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  Future<User> getUserData(String userId) async{

    final userSnapshot = await firebaseFirestore.collection('users').doc(userId).get();
    final user = User.fromDocumentSnapshot(documentSnapshot: userSnapshot);
    return user;

  }
  Future<void> assignCollegeAndProgram(String collegeId, String programId) async {
    final userDocRef = firebaseFirestore.collection('users').doc(auth.currentUser!.uid);

    try {
      // Update the user's document with collegeId and programId
      await userDocRef.update({
        'college': collegeId,
        'program': programId,
      });

      print("Successfully assigned college and program.");
    } catch (e) {
      print("Error assigning college and program: $e");

      // Handle cases where the user document does not exist
      if (e.toString().contains('NOT_FOUND')) {
        print("User document does not exist.");
      }
    }
  }
  Future<void> checkIfAssignedCollege() async{
    final userSnapshot = await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).get();
    
    // Check if the "college" field exists and is not null
      if (userSnapshot.exists && userSnapshot.data() != null) {
        var data = userSnapshot.data() as Map<String, dynamic>;
        var isAssignedCollege = data.containsKey('college') && data['college'] != null;
        if (!isAssignedCollege) Get.offAll(const ViewCollegeList());
      }
  }
  Future <void> registerUserToFirestore(String email, String firstName, String lastName) async {
    // TODO: Add college and course here
    await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });
  }
}
