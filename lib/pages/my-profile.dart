import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/profile_header.dart';

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
      appBar: StandardAppBar(
        title: 'My Profile',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: const Column(
        children: <Widget>[
          ProfileHeader(
              username: "Enrique Lejano",
              collegeName: "College of Computer Studies",
              collegeAcronym: "CCS",
              programName: "BSMS Computer Science Major in Software Technology",
              programAcronym: "BSMS-CS"
          ),
        ],
      ),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
    );
  }
}

