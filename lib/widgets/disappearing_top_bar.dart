import 'package:flutter/material.dart';

class DisappearingTopBar extends StatelessWidget {
  final Widget body;
  final List<Widget>? actions;
  const DisappearingTopBar({
    super.key,
    required this.body,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            actions: actions ?? [],
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(color: Colors.grey, height: 1.0)
            ),
          )
        ],
        body: body
    );
  }
}