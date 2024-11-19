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
      body: Column(
        children: <Widget>[
          const ProfileHeader(
              username: "Enrique Lejano",
              collegeName: "College of Computer Studies",
              collegeAcronym: "CCS",
              programName: "BSMS Computer Science Major in Software Technology",
              programAcronym: "BSMS-CS"
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                          onPressed: () {}, // TODO: Can insert third-party APIs for sharing.
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary
                          ),
                          child: Text(
                            "Share",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary
                            )
                          )
                      ),
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).dividerColor
                        )
                    ),
                      child: Text(
                        "Edit",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black
                        )
                      )
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
    );
  }
}

