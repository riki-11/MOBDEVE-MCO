import 'package:flutter/material.dart';
class ArticleContainerListView extends StatelessWidget {
  final String authorName;
  final String title;
  final String college;
  final DateTime date;

  const ArticleContainerListView({super.key, required this.authorName, required this.title, required this.college, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      height: 200.0,
      // color: Colors.green,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))
      ),
      child: Column(
        children: [
          Text(authorName),
          Text(title),
          Text(college),
          Text(date.toString()),
        ],
      ),
    );
  }
}
