
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/controllers/login_controller.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/pages/login.dart';
import 'package:mobdeve_mco/authentication/signup_email_password_failure.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/pages/landing.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const LandingPage(title: "UniGuide"))
        : Get.offAll(() => HomePage(controller: ArticleController()));
    LoginController.instance.checkUserInCloudFirestore();
  }
  
  Future<void> createUserWithEmailAndPassword(String email, String password, String firstName, String lastName) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await UserController.instance.registerUserToFirestore(email, firstName, lastName);
    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(e){
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${e}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => HomePage(controller: ArticleController())) : Get.to(() => const LoginPage());

    } on FirebaseAuthException catch(e){
      print("ERROR $e");
    } catch(_){
      print("ERROR");
    }
  }

  Future<void> logout() async => await _auth.signOut();

}
