import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/create_list_popup.dart';
import 'package:mobdeve_mco/widgets/library_tab_bar.dart';
import 'package:mobdeve_mco/widgets/list_container_view.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';

class YourLibrary extends StatefulWidget {
  final int pageIndex;
  const YourLibrary({this.pageIndex = 1, super.key});

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  late int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
  }

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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateListPopup();
                      }
                    );
                  },
                  icon: const Icon(Icons.add),
                  tooltip: 'Add to library'
              )
            ],
            tabBar: const LibraryTabBar()
        ),
        body: const TabBarView(
          children: <Widget>[
            // Your Lists Tab
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListContainerView()
              ],
            ),
            Center(child: Text("Highlights")),
            Center(child: Text("Recently Read")),
          ]
        ),
        bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
      ),
    );}
}