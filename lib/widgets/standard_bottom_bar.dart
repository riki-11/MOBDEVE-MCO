import 'package:flutter/material.dart';

class StandardBottomBar extends StatefulWidget {
  final int curPageIndex;
  const StandardBottomBar({required this.curPageIndex, super.key});

  @override
  State<StandardBottomBar> createState() => _StandardBottomBarState();
}

class _StandardBottomBarState extends State<StandardBottomBar> {
  late int curPageIndex;

  @override initState() {
    super.initState();
    curPageIndex = widget.curPageIndex;
  }

  void onDestinationTapped(int index) {

    // TODO: Add page refreshing functionality here.
    if (curPageIndex == index) return;

    setState(() {
      curPageIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          '/home',
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(
          context,
          '/library',
        );
        break;
      // TODO: insert Conversations page when ready.
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/my-profile',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0,
          )
        )
      ),
      child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .10,
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedIndex: curPageIndex,
            onDestinationSelected: onDestinationTapped,
            destinations: const <Widget>[
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.bookmarks_outlined), label: 'Library'),
              // TODO: Add implementation for this page.
              // NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Conversations'),
              NavigationDestination(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ],
          )
      )
    );
  }
}