import 'package:flutter/material.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/pages/view-course-list.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';


class HomePage extends StatefulWidget {
  final int pageIndex;
  final ArticleController controller;
  const HomePage({
    super.key,
    this.pageIndex = 0,
    required this.controller,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isToggled = false;
  late int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
      title: 'Articles',
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  _isToggled = !_isToggled;
                });
              },
              icon: const Icon(Icons.filter_alt_outlined)
          ),
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String article = 'Article $index';
                return ListTile(
                    title: Text(article),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ViewArticle())
                      );
                    }
                );
              });
            },
            viewBuilder: (suggestions){
              return Column(
                children: [

                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: suggestions.toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              tooltip: 'Notification'
          )
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: _isToggled,
            child: Card(
              elevation: 10,
              margin: EdgeInsets.all(10),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Tags",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    MultiSelectContainer(
                      itemsDecoration: MultiSelectDecorations(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      items: [
                        MultiSelectCard(value: 'Projects', label: 'Projects'),
                        MultiSelectCard(value: 'Tips for Doing Well', label: 'Tips for Doing Well'),
                        MultiSelectCard(value: 'What You’ll Learn', label: 'What You’ll Learn'),
                        MultiSelectCard(value: 'Thoughts and Experiences', label: 'Thoughts and Experiences'),
                      ],
                      onChange: (allSelectedItems, selectedItem) {}),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StandardScrollbar(
              child: ListView.builder(
                itemCount: widget.controller.articles.length,
                itemBuilder: (context, index) {
                  final article = widget.controller.articles[index];
                  return ArticleContainerListView(
                    authorName: article.authorId, 
                    title: article.title, 
                    college: "FOO", 
                    date: article.datePosted,
                    );
                },
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ViewCourseList())
          );
        },
        tooltip: 'Create',
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex)
    );
  }
}
