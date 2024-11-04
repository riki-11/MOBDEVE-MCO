import 'package:flutter/material.dart';
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
    DropdownItem(label: 'Nepal', value: 1),
    DropdownItem(label: 'Test 2', value: 2)
  ];
  @override
  Widget build(BuildContext context) {
    final dropdownController = MultiSelectController<int>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articles',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
            tooltip: 'Search Article'
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
            controller: dropdownController,
            dropdownDecoration: const DropdownDecoration(
              maxHeight: 200.0,
            ),
            fieldDecoration: const FieldDecoration(
              hintText: null,
              border: null,
              suffixIcon: null,
              borderRadius: 0.0,
              padding: EdgeInsets.all(5.0),
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