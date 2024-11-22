import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../controllers/article_controller.dart';
import '../models/article.dart';
import '../models/college.dart';
import '../models/program.dart';
import '../widgets/article_container_list_view.dart';
import '../widgets/social_media_sharing_popup.dart';
import '../widgets/standard_scrollbar.dart';

class ViewArticlesList extends StatefulWidget {
  final String listTitle;
  final String listDescription;
  final String createdBy;

  final ArticleController controller;
  const ViewArticlesList({
    super.key,
    required this.listTitle,
    required this.listDescription,
    required this.createdBy,
    required this.controller
  });

  @override
  State<ViewArticlesList> createState() => _ViewArticlesListState();
}

class _ViewArticlesListState extends State<ViewArticlesList> {
  late String listTitle;
  late String listDescription;
  late String createdBy;

  @override
  void initState() {
    super.initState();
    listTitle = widget.listTitle;
    listDescription = widget.listDescription;
    createdBy = widget.createdBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey, height: 1.0)
        ),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder:  (BuildContext context) {
                      return const SocialMediaSharingPopup();
                    }
                );
              },
              icon: const Icon(Icons.ios_share_rounded)
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  listTitle,
                  style: Theme.of(context).textTheme.headlineLarge
                ),
                const SizedBox(height: 8.0),
                Text(
                  "List by $createdBy",
                  style: Theme.of(context).textTheme.bodyMedium
                ),
                const SizedBox(height: 8.0),
                Text(
                  listDescription,
                  style: Theme.of(context).textTheme.bodyLarge
                )
              ]
            ),
          ),
          const SizedBox(height: 8.0),
          // TODO: Insert articles here.
        ],
      )
    );
  }
}