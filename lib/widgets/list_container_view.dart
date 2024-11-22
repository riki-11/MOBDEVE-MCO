import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/pages/view-articles-list.dart';

import '../controllers/article_controller.dart';

class ListContainerView extends StatelessWidget {
  const ListContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace this with real data.
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(10),
          height: 170.0,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
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
                  Text(
                    "Freshman Year",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  Text(
                    "List by riki11",
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  Text(
                    "A list with guides for all my 1st year subjects in ComSci at DLSU.",
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                ],
              )
            )
          ],
        )
      ),
      onTap: () {
        // TODO: Lead to real list page.
        Get.to(() => ViewArticlesList(
            listTitle: 'Freshman Year',
            listDescription: 'A list with guides for all my 1st year subjects in ComSci at DLSU.',
            createdBy: "riki11",
            controller: ArticleController()
          )
        );
      }
    );
  }

}