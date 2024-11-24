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
import '../models/user.dart';
import '../widgets/article_container_list_view.dart';
import '../widgets/social_media_sharing_popup.dart';
import '../widgets/standard_app_bar.dart';
import '../widgets/standard_scrollbar.dart';

class ViewArticlesList extends StatefulWidget {
  final ListModel list;
  final User listCreator;

  const ViewArticlesList({
    super.key,
    required this.list,
    required this.listCreator
  });

  @override
  State<ViewArticlesList> createState() => _ViewArticlesListState();
}

class _ViewArticlesListState extends State<ViewArticlesList> {
  late ListModel list;
  late User listCreator;

  // Formatted variables for link-sharing
  late String formattedTitle;
  // TODO: Add the username into the list info as well.
  late String formattedCreatorName;

  @override
  void initState() {
    super.initState();
    list = widget.list;
    listCreator = widget.listCreator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: '',
        automaticallyImplyleading: true,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              formattedTitle = widget.list.title.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
              formattedCreatorName = "${listCreator.firstName} ${listCreator.lastName}".toLowerCase().replaceAll(RegExp(r'\s+'), '-');
              final result = await Share.share(
                'Check out "${list.title}", a list containing helpful articles about doing well in university at https://uniguide.com/$formattedCreatorName/$formattedTitle.'
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
            padding: const EdgeInsets.all(16.0),
            // TODO: Redesign the divider here.
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  list.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4.0),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black54,
                    ),
                    children: [
                      const WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 4.0),
                      ),
                      TextSpan(
                        text: '${listCreator.firstName} ${listCreator.lastName}',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  list.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
                if (list.articlesBookmarked.isEmpty)
                  Text(
                    'No articles',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                if (list.articlesBookmarked.length == 1)
                  Text(
                    '1 article',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                if (list.articlesBookmarked.length > 1)
                  Text(
                    '${list.articlesBookmarked.length} articles',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
              ]
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: FutureBuilder(
              future: ListController.instance.getArticlesFromArticleArray(widget.list.articlesBookmarked),
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

                return StandardScrollbar(
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          final articleModel = articles[index];

                          return Dismissible(
                              key: Key(articleModel.id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) async {
                                // TODO: Add deletion behavior
                                Article articleRemoved = articles.removeAt(index);
                                if(articleRemoved.id == null){
                                  throw Exception("Error removing article: article has no id");
                                }
                                await ListController.instance.deleteArticleFromList(widget.list, articleRemoved.id as String);
                                // show notification to confirm deletion
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Removed article from list.'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      onPressed: () async {
                                        // Reinstate the article to the list
                                        await ListController.instance.addArticleFromList(widget.list, articleRemoved.id as String);
                                        setState(() {
                                          articles.insert(index, articleRemoved);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Icon(Icons.delete, color: Colors.white)
                              ),
                              child: ArticleContainerListView(article: articleModel)
                          );
                        }
                )
                );
              },
            ),
          )
        ],
      )
    );
  }
}
