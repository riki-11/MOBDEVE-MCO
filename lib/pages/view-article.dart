import 'package:flutter/material.dart';

import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/widgets/disappearing_top_bar.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({super.key});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisappearingTopBar(
          body: StandardScrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How I got a 4.0 in CSOPESY",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      // TODO: Fade this text a bit.
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
                              // TODO: Bold the name.
                                "Enrique Lejano",
                                style: Theme.of(context).textTheme.bodyMedium
                            ),
                            Text(
                                "OCT 11, 2024",
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
                      "This is the body of the article. " * 1000,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
          )
      )
    );
  }
}

