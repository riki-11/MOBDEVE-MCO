import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/library_tab_bar.dart';
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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: StandardAppBar(
            title: 'Your Library',
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  tooltip: 'Add to library'
              )
            ],
            tabBar: const LibraryTabBar()
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: Text("Your Lists")),
            Center(child: Text("Highlights")),
            Center(child: Text("Recently Read")),
          ]
        ),
        bottomNavigationBar: const StandardBottomBar(),
      ),
    );}
}