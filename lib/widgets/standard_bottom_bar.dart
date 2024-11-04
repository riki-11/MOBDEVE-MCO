import 'package:flutter/material.dart';

class StandardBottomBar extends StatelessWidget {
  const StandardBottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * .10,
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).colorScheme.surface,
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.bookmarks_outlined), label: 'Library'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Conversations'),
            NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
          ],
        )
    );
  }
}