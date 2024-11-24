import 'package:flutter/material.dart';
import 'package:mobdeve_mco/controllers/reaction_controller.dart';
import 'package:mobdeve_mco/widgets/add_article_to_list.dart';

import '../controllers/list_controller.dart';

class ArticleBottomBar extends StatefulWidget {
  final String articleId;
  const ArticleBottomBar({super.key, required this.articleId});

  @override
  State<ArticleBottomBar> createState() => _ArticleBottomBarState();
}

class _ArticleBottomBarState extends State<ArticleBottomBar> {
  bool isLiked = false;
  bool isBookmarked = false;
  String currentLikesNumber = "0";

  void _handleBookmarkStatusChanged(bool isBookmarkedNow) {
    setState(() {
      isBookmarked = isBookmarkedNow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () async {
                  bool isLikedNow = await ReactionController.isArticleLikedByUser(widget.articleId);
                  if (isLikedNow) {
                    await ReactionController.unlikePost(widget.articleId);
                    setState(() {
                      isLiked = false;
                    });
                  } else {
                    await ReactionController.likePost(widget.articleId);
                    setState(() {
                      isLiked = true;
                    });
                  }
                },
              ),
              FutureBuilder<int>(
                future: ReactionController.instance.getLikeCountOfArticle(widget.articleId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(currentLikesNumber);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  }
                  currentLikesNumber = snapshot.data.toString();
                  return Text(snapshot.data.toString() ?? '-1');
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
              color: isBookmarked ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return AddArticleToList(
                    articleId: widget.articleId,
                    onBookmarkStatusChanged: _handleBookmarkStatusChanged,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    bool liked = await ReactionController.isArticleLikedByUser(widget.articleId);

    // Determine if the article is bookmarked
    bool bookmarked = ListController.instance.currentUserLists.value.any(
          (list) => list.articlesBookmarked.contains(widget.articleId),
    );

    setState(() {
      isLiked = liked;
      isBookmarked = bookmarked;
    });
  }
}

