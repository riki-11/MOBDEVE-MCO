import 'package:flutter/material.dart';
import 'package:mobdeve_mco/controllers/reaction_controller.dart';
import 'package:mobdeve_mco/widgets/add_article_to_list.dart';

class ArticleBottomBar extends StatefulWidget {
  final String articleId;
  const ArticleBottomBar({super.key, required this.articleId});

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
                    // Show a loading indicator while fetching data
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle error state
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    // Handle the case where there's no data
                    return const Center(child: Text('No data available'));
                  }
                  return Text(snapshot.data.toString() ?? '-1');
                }
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
              color: isBookmarked ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return AddArticleToList(articleId: widget.articleId);
                    }
                );
                isBookmarked = !isBookmarked;
              });
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
  _initializeState() async {
    // Simulate an asynchronous operation, like fetching data or checking a condition
    bool liked = await ReactionController.isArticleLikedByUser(widget.articleId);

    // Update state after the async operation is done
    setState(() {
      isLiked = liked;
    });
    print("THE ARTICLE ${widget.articleId} isLiked: $isLiked");
  }
  // Future<void> initLikes() async {
  //   isLiked = await ReactionController.isArticleLikedByUser()
  // }
}
