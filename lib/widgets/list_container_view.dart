import 'package:flutter/material.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/pages/view-articles-list.dart';

import '../controllers/article_controller.dart';

class ListContainerView extends StatelessWidget {
  final ListModel list;
  const ListContainerView({super.key, required this.list});

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
                    list.title,
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  Text(
                    list.description,
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
