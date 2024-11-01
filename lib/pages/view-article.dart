import 'package:flutter/material.dart';

import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({super.key});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          )
        ]
      ),
      body: StandardScrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0), // Optional padding for content spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How I got a 4.0 in CSOPESY",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16.0), // Spacing between title and content
                Text(
                  "This is the body of the article. " * 1000, // Example of long content
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ))
    );
  }
}