import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? tabBar;

  const StandardAppBar({
    super.key,
    required this.title,
    this.actions,
    this.tabBar
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .headlineLarge,
      ),
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      actions: actions ?? [],
      bottom: tabBar
    );
  }

  @override
  Size get preferredSize {
    // Dynamically incorporates the tab bar's height, if it exists.
    final tabBarHeight = tabBar?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + tabBarHeight);
  }
}