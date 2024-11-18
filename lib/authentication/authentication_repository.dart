
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/articles/controller/article_controller.dart';
import 'package:mobdeve_mco/authentication/screens/login.dart';
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
  }
  
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(_){
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => HomePage(controller: ArticleController())) : Get.to(() => const LoginPage());

    } on FirebaseAuthException catch(e){
      print("ERROR");
    } catch(_){
      print("ERROR");
    }
  }

  Future<void> logout() async => await _auth.signOut();

}
