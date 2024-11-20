import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'package:mobdeve_mco/widgets/article_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/social_media_sharing_popup.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/widgets/disappearing_top_bar.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({super.key});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  bool showBottomBar = true;
  var data = Get.arguments;
  void onScroll(Notification notif) {
    if (notif is UserScrollNotification) {
      final scrollDirection = notif.direction;
      if (scrollDirection == ScrollDirection.reverse && showBottomBar) {
        setState(() {showBottomBar = false;});
      } else if (scrollDirection == ScrollDirection.forward && !showBottomBar) {
        setState(() {showBottomBar = true;});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisappearingTopBar(
          actions: [
            IconButton(
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    builder:  (BuildContext context) {
                      return const SocialMediaSharingPopup();
                    }
                  );
                },
                icon: const Icon(Icons.ios_share_rounded)),
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
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notif) {
              onScroll(notif);
              return true;
            },
            child: StandardScrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                          "This is a short description of the article",
                          style: Theme.of(context).textTheme.bodyLarge
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  data['authorName'],
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w600
                                  )
                              ),
                              Text(
                                DateFormat.yMMMd().format(data['date']),
                                style: Theme.of(context).textTheme.bodySmall
                              ),
                            ],
                          ),
                          const Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.account_circle_rounded)
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0), // Spacing between title and content
                      Text(
                        // TODO: Add proper styling that is similar to article-write later
                        data['content'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
            ),
          )
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: showBottomBar ? kBottomNavigationBarHeight : 0.0,
        child: ArticleBottomBar(
          articleId: data['articleId'],
        ),
      )
    );
  }
}

