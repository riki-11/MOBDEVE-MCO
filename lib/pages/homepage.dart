import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/widgets/filter_articles_popup.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/pages/view-college-list.dart';
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
  late int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
    _checkCollegeAssignment();
  }

  Future<void> _checkCollegeAssignment() async {
    await UserController.instance.checkIfAssignedCollege();
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

        ]
      ),
      body: Stack(
        children: <Widget>[
          StandardScrollbar(
            child: GetX<ArticleController>(
              init: Get.put<ArticleController>(ArticleController()),
              builder: (ArticleController articleController) {
                return ListView.builder(
                  itemCount: articleController.articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("ARTICLE PRINT: ${articleController.articles[index].content}");
                    final articleModel = articleController.articles[index];
                    return ArticleContainerListView(
                        article: articleModel
                    );
                  }
                );
              }
            ),
          ),
          Visibility(
            visible: _isToggled,
            child: const FilterArticlesPopup()
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateArticle());
        },
        tooltip: 'Create',
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex)
    );
  }
}
