import 'package:flutter/material.dart';

class StandardScrollbar extends StatelessWidget {
  final Widget child;
  final double scrollbarThickness;
  final double scrollbarRadius;

  const StandardScrollbar({
    super.key,
    required this.child,
    this.scrollbarThickness = 8.0,
    this.scrollbarRadius = 8.0
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thickness: scrollbarThickness,
      radius: Radius.circular(scrollbarRadius),
      child: child
    );
  }
}