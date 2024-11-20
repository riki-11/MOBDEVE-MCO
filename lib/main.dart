import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/pages/landing.dart';
import 'package:mobdeve_mco/pages/my-profile.dart';
import 'package:mobdeve_mco/pages/your-library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'helpers/firestore_seeder.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true; // Uncomment and restart app if you want to see page and widget layouts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
  // Uncomment this to add dummy data to Cloud Firestore
  // FirestoreSeeder seeder = FirestoreSeeder();
  // await seeder.seedData();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UniGuide',
      // Defines the fonts, color themes, etc. for the entire app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        // Default font family is Merriweather.
        fontFamily: GoogleFonts.merriweather().fontFamily,
        // Define specific font for body text
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.sourceSans3(),
          bodyMedium: GoogleFonts.sourceSans3(),
          bodySmall: GoogleFonts.sourceSans3(),
        )
      ),
      home: HomePage(
          controller: ArticleController(),
        ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(title: 'UniGuide'),
        '/home': (context) => HomePage(
           pageIndex: 0,
           controller: ArticleController(),
        ),
        '/library': (context) => const YourLibrary(pageIndex: 1),
        // TODO: insert Conversations page when ready.
        '/my-profile': (context) => const MyProfilePage(pageIndex: 2)
      },
    );
  }
}
