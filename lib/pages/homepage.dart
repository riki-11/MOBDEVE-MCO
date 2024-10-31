import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notification'
          )
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.filter_alt_outlined)
                    ),
                  ],
                );
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String article = 'Article $index';
                  return ListTile(
                    title: Text(article),
                    onTap: () {
                      setState(() {
                        controller.closeView(article);
                      });
                    }
                  );
                });
              },
          ),
          Expanded(
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