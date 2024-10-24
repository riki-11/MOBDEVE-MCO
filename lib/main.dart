import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobdeve_mco/pages/landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MyHomePage(title: 'UniGuide'),
    );
  }
}
