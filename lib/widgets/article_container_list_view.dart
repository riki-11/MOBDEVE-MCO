import 'package:flutter/material.dart';
import 'package:mobdeve_mco/pages/view-article.dart';


class ArticleContainerListView extends StatelessWidget {
  final String authorName;
  final String title;
  final String college;
  final DateTime date;

  const ArticleContainerListView({super.key, required this.authorName, required this.title, required this.college, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(10),
        height: 170.0,
        // color: Colors.green,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))
        ),
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
                  Expanded(child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ),
                  Card(
                    color: Colors.black,    // ← And also this.
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                          college,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.purple,
                    width: 100,
                    height: 65,
                  ), // replace with a placeholder image
                  Text(date.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewArticle())
        );
      },
    );
  }
}
