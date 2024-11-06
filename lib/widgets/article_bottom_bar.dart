import 'package:flutter/material.dart';

class ArticleBottomBar extends StatefulWidget {
  const ArticleBottomBar({super.key});

  @override
  State<ArticleBottomBar> createState() => _ArticleBottomBarState();
}

class _ArticleBottomBarState extends State<ArticleBottomBar> {
  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //color: Theme.of(context).colorScheme.surface,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 1.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                  // TODO: Change this to darker shade of red
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
              ),
              const Text("153"),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chat_outlined),
                onPressed: () {},
              ),
              const Text("15")
            ]
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
              color: isBookmarked ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
          ),
        ],
      ),
    );
  }
}
