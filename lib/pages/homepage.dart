import 'package:flutter/material.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var items = [
    DropdownItem(label: 'Thoughts', value: 1),
    DropdownItem(label: 'What You\'ll Learn', value: 1),
    DropdownItem(label: 'Projects', value: 1),
    DropdownItem(label: 'Tips for doing well', value: 1),
    DropdownItem(label: 'Links and Resources', value: 2)
  ];
  @override
  Widget build(BuildContext context) {
    final _dropdownController = MultiSelectController<int>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articles',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
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
          MultiDropdown<int>(
            items: items,
            controller: _dropdownController,
            dropdownDecoration: const DropdownDecoration(
              maxHeight: 200.0,
            ),
            fieldDecoration: const FieldDecoration(
              prefixIcon: Icon(Icons.filter_alt_outlined),
              // border: null,
              // suffixIcon: null,
              // borderRadius: 0.0,
              padding: EdgeInsets.all(5.0),
            ),
            chipDecoration: ChipDecoration(
              labelStyle: Theme.of(context).textTheme.labelSmall
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
            )
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