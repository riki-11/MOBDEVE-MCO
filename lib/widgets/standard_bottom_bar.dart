import 'package:flutter/material.dart';

class StandardBottomBar extends StatefulWidget {
  const StandardBottomBar({super.key});

  @override
  State<StandardBottomBar> createState() => _StandardBottomBarState();
}

// FIXME: Ensure that the selected page index is maintained when switching over to a new page.
class _StandardBottomBarState extends State<StandardBottomBar> {
  int curPageIndex = 0;

  void onDestinationTapped(int index) {
    setState(() {
      curPageIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/library');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/conversations');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/user-profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * .10,
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedIndex: curPageIndex,
          onDestinationSelected: onDestinationTapped,
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