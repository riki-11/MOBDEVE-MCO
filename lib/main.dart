import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/controllers/college_controller.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';
import 'package:mobdeve_mco/controllers/login_controller.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/pages/landing.dart';
import 'package:mobdeve_mco/pages/my-profile.dart';
import 'package:mobdeve_mco/pages/your-library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/program_controller.dart';
import 'controllers/reaction_controller.dart';
import 'firebase_options.dart';
import 'helpers/firestore_seeder.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true; // Uncomment and restart app if you want to see page and widget layouts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try{
    Get.put(AuthenticationRepository());
    Get.put(ArticleController());
    Get.put(LoginController());
    Get.put(UserController());
    Get.put(CollegeController());
    Get.put(ProgramController());
    Get.put(ReactionController());
    Get.put(ListController());
  }
  catch (e){
    print("Get.put Error in main: $e");
  }

  runApp(const MyApp());
  // Uncomment this to add dummy data to Cloud Firestore
  // FirestoreSeeder seeder = FirestoreSeeder();
  // await seeder.seedData();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UniGuide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: GoogleFonts.merriweather().fontFamily,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.sourceSans3(),
          bodyMedium: GoogleFonts.sourceSans3(),
          bodySmall: GoogleFonts.sourceSans3(),
        ),
      ),
      initialRoute: '/landing',
      getPages: [
        GetPage(
          name: '/landing',
          page: () => const LandingPage(title: 'UniGuide'),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(pageIndex: 0, controller: ArticleController()),
        ),
        GetPage(
          name: '/library',
          page: () => const YourLibrary(pageIndex: 1),
        ),
        GetPage(
          name: '/my-profile',
          page: () => const MyProfilePage(pageIndex: 2),
        ),
      ],
    );
  }
}
