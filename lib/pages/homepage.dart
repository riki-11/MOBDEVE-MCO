import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/college.dart';
import 'package:mobdeve_mco/models/program.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:mobdeve_mco/widgets/article_container_list_view.dart';
import 'package:mobdeve_mco/widgets/filter_articles_popup.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/pages/view-college-list.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import '../models/article.dart';


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
                // Filter by college filter and program filter found in ArticleController

                print("Current Program Filter: ${articleController.programFilter}");
                print("Current College Filter: ${articleController.collegeFilter}");
                  List<Article> filteredArticles = articleController.articles.where((article) {
                    ArticleController articleController = ArticleController
                        .instance;
                    College collegeFilter = articleController.collegeFilter.value ?? College.defaultInstance();
                    Program programFilter = articleController.programFilter.value ?? Program.defaultInstance();

                    // If no filter, show everything
                    return articleController.collegeFilter.value == null ||
                        (article.collegeId == collegeFilter.id &&
                            article.programId == programFilter.id) || (article.collegeId == collegeFilter.id);
                    // if college filter and program filter
                  }).toList();

                  

                return ListView.builder(
                  itemCount: filteredArticles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final articleModel = filteredArticles[index];
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
