import 'package:flutter/material.dart';

class DisappearingTopBar extends StatelessWidget {
  final Widget body;
  const DisappearingTopBar({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            actions: [
              PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz),
                  onSelected: (String value) {
                    print("Selected option: $value");
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'report-article',
                      child: Text('Report article', style: Theme.of(context).textTheme.bodyMedium),
                    )
                  ]
              ),
            ],
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