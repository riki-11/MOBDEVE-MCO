import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:intl/intl.dart';
class ArticleContainerListView extends StatelessWidget {
  final String authorName;
  final String title;
  final String college;
  final DateTime date;
  final String articleId;
  final String authorId;
  final String content;

  const ArticleContainerListView(
      {super.key,
      required this.authorName,
      required this.title,
      required this.college,
      required this.date,
      required this.articleId,
        required this.content, required this.authorId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(10),
          height: 170.0,
          // color: Colors.green,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(authorName),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Card(
                        color: Colors.black, // ← And also this.
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(college,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                color: Colors.green, // Inner green container
                                height:
                                    65, // Adjust height to fit inside the purple container
                              ),
                            ),
                          ),
                          Text(DateFormat.yMMMd().format(date)),
                        ],
                      ),
                    )),
              ],
            ),
          )),
      onTap: () {
        Get.to(const ViewArticle(), transition: Transition.rightToLeft, arguments: {
          'authorName': authorName,
          'title': title,
          'college': college,
          'date': date,
          'articleId': articleId,
          'content': content,
        });
      },
    );
  }
}
