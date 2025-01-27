import 'package:flutter/material.dart';

class LibraryTabBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
          child: Text("Your Lists"),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}