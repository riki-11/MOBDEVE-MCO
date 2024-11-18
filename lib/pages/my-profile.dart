import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';

class MyProfilePage extends StatefulWidget {
  final int pageIndex;
  const MyProfilePage({this.pageIndex = 2, super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: 'Profile'),
      body: const SizedBox(),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
    );
  }
}

