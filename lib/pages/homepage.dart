import 'package:flutter/material.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isToggled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articles',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: <Widget>[
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
              child: ListView(
                children: [
                  ArticleContainerListView(
                    authorName: "Enrique Lejano",
                    title: "The Ultimate Guide to Computer Science at DLSU (Junior Year, Term 1)",
                    college: "CCS",
                    date: DateTime.now(),
                  ),
                  ArticleContainerListView(
                    authorName: "Luis Roxas",
                    title: "Why bouldering made me decide to shift from CCS to COB",
                    college: "COB",
                    date: DateTime.now(),
                  ),
                  ArticleContainerListView(
                    authorName: "Patrick Leonida",
                    title: "I'm a star that live sunder the ocean",
                    college: "CCS",
                    date: DateTime.now(),
                  ),
                  ArticleContainerListView(
                      authorName: "Lebron James",
                      title: "Why Basketball sucks and we should all play football (#stoptheads)",
                      college: "GCOE",
                      date: DateTime.now()
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateArticle())
          );
        },
        tooltip: 'Create',
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: const StandardBottomBar()
    );
  }
}