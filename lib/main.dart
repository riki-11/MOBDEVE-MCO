import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobdeve_mco/articles/controller/article_controller.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/pages/landing.dart';
import 'package:mobdeve_mco/pages/your-library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true; // Uncomment and restart app if you want to see page and widget layouts
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
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
        '/library': (context) => const YourLibrary(pageIndex: 1)
      },
    );
  }
}
