import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/article_controller.dart';
import '../models/article.dart';
import '../models/college.dart';
import '../models/program.dart';
import '../widgets/article_container_list_view.dart';
import '../widgets/social_media_sharing_popup.dart';
import '../widgets/standard_scrollbar.dart';

class ViewArticlesList extends StatefulWidget {
  final ListModel list;

  const ViewArticlesList({
    super.key,
    required this.list,
  });

  @override
  State<ViewArticlesList> createState() => _ViewArticlesListState();
}

class _ViewArticlesListState extends State<ViewArticlesList> {
  // Formatted variables for link-sharing
  late String formattedTitle;
  // TODO: Add the username into the list info as well.
  late String formattedCreatorName;

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
            onPressed: () async {
              formattedTitle = widget.list.title.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
              final result = await Share.share(
                'Check out "${widget.list.title}", a list containing helpful UniGuide articles at https://uniguide.com/$formattedTitle.'
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
                  widget.list.title,
                  style: Theme.of(context).textTheme.headlineLarge
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.list.description,
                  style: Theme.of(context).textTheme.bodyLarge
                )
              ]
            ),
          ),
          const SizedBox(height: 8.0),
          // TODO: Insert articles here.
          FutureBuilder(
            future: ListController.instance.getArticlesFromArticleArray(widget.list.articleIds), 
            builder: (context, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while fetching data
                return const SizedBox(
                  height: 170.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                // Handle error state
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                // Handle the case where there's no data
                return const Center(child: Text('No data available'));
              }
              List<Article> articles = snapshot.data! as List<Article>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  final articleModel = articles[index];
                  return ArticleContainerListView(article: articleModel);
                }
              ); 
                  
                
              
            },
            ),
        ],
      )
    );
  }
}
