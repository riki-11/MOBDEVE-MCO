import 'package:get/get.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/pages/view-course-list.dart';

class UserController extends GetxController{
  static UserController get instance => Get.find();

  Future<User> getUserData(String userId) async{

    final userSnapshot = await firebaseFirestore.collection('users').doc(userId).get();
    final user = User.fromDocumentSnapshot(documentSnapshot: userSnapshot);
    return user;

  }

  
  Future<void> checkIfAssignedCollege() async{
    final userSnapshot = await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).get();
    
    // Check if the "college" field exists and is not null
      if (userSnapshot.exists && userSnapshot.data() != null) {
        var data = userSnapshot.data() as Map<String, dynamic>;
        var isAssignedCollege = data.containsKey('college') && data['college'] != null;
        if (!isAssignedCollege) Get.offAll(const ViewCourseList());
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
