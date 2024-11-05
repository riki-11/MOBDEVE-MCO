import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';

class YourLibrary extends StatefulWidget {
  const YourLibrary({super.key});

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: 'Your Library',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            tooltip: 'Add to library'
          )
        ],
      ),
      bottomNavigationBar: const StandardBottomBar(),
    );
  }
}