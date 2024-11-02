import 'package:flutter/material.dart';

class StandardBottomBar extends StatelessWidget {
  const StandardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: IntrinsicHeight(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.home_outlined),
                      tooltip: 'Visit homepage',
                    ),
                  ),
                  Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        tooltip: 'Search',
                      )
                  ),
                  Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmarks_outlined),
                        tooltip: 'Saved',
                      )
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.account_circle_outlined)
                      )
                  )
                ]
            )
        )
    );
  }
}