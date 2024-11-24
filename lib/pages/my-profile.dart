import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mobdeve_mco/pages/settings.dart';
import 'package:mobdeve_mco/widgets/profile_content_dropdown.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/profile_header.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/article_controller.dart';
import '../controllers/list_controller.dart';
import '../controllers/user_controller.dart';
import '../models/article.dart';
import '../models/college.dart';
import '../models/list.dart';
import '../models/program.dart';
import '../models/user.dart';
import '../widgets/article_container_list_view.dart';
import '../widgets/list_container_view.dart';
import '../widgets/standard_scrollbar.dart';

class MyProfilePage extends StatefulWidget {
  final int pageIndex;
  final String? userId; // Optional user ID to view another user's profile
  const MyProfilePage({this.pageIndex = 2, this.userId, super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  final UserController userController = UserController.instance;
  final RxString selectedContent = 'Articles'.obs; // Tracks the dropdown selection

  late int pageIndex;
  late TabController _tabController;
  late User? user;
  late College? userCollege;
  late Program? userProgram;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
    _tabController = TabController(length: 2, vsync: this);

    // Fetch data for a specific user or a current user
    if (widget.userId != null) {
      print("Displaying another user's profile!");
    } else {
      // Display profile of current user
      user = userController.currentUser.value;
      userCollege = userController.currentUserCollege.value;
      userProgram = userController.currentUserProgram.value;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: 'My Profile',
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Use LoginController.instance.logoutUser(); ?
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SettingsPage(); // Custom settings content
                },
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Obx(() {
        var user = userController.currentUser.value;
        var college = userController.currentUserCollege.value;
        var program = userController.currentUserProgram.value;

        // Show a loading spinner while data is being fetched
        if (user == null || college == null || program == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: <Widget>[
            ProfileHeader(
              username: user.getName(),
              collegeName: college.name,
              collegeAcronym: college.acronym,
              programName: program.name,
              programAcronym: program.acronym,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () async {
                          var formattedUsername = user.getName().toLowerCase().replaceAll(RegExp(r'\s+'), '-');
                          final result = await Share.share(
                              'Check out my profile at https://uniguide.com/$formattedUsername.'
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          "Share",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () {}, // TODO: Add editing functionality.
                        style: TextButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: Text(
                          "Edit",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              width: double.infinity,
              // TODO: When switching to 'Lists' dropdown, query for lists instead of articles and display them in the same container.
              child: ProfileContentDropdown(
                options: ['Articles', 'Lists'],
                onChanged: (String? selected) {
                  selectedContent.value = selected!; // Update the selected content
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                // display either articles or lists depending on dropdown selection.
                if (selectedContent.value == 'Articles') {
                  return Column(
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          tabs: const [
                            Tab(text: "Published"),
                            Tab(text: "Drafts"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            Expanded(
                              child: StandardScrollbar(
                                child: GetX<ArticleController>(
                                  init: Get.put<ArticleController>(ArticleController()),
                                  builder: (ArticleController articleController) {
                                    var currentUserId = UserController.instance.currentUser.value;
                                    List<Article> articleOfUserList = articleController.articles.where((article) => article.authorId == currentUserId?.id).toList();
                                    return ListView.builder(
                                      itemCount: articleOfUserList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final articleModel = articleOfUserList[index];
                                        return ArticleContainerListView(
                                          article: articleModel
                                        );
                                      }
                                    );
                                  }
                                ),
                              ),
                            ),
                            Center(child: Text("Drafts here")),
                          ],
                        ),
                      ),
                    ]
                  );
                } else if (selectedContent.value == 'Lists') {
                  return StandardScrollbar(
                    child: GetX<ListController>(
                        init: Get.put<ListController>(ListController()),
                        builder: (ListController listController) {
                          List<ListModel> listOfUserList = ListController.instance.currentUserLists.value;
                          return ListView.builder(
                            itemCount: listOfUserList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final listModel = listOfUserList[index];
                              return ListContainerView(list: listModel);
                            },
                          );
                        }
                    ),
                  );
                } else {
                  return const Center(child: Text("No content available"));
                }
              }
            )
          ) // TabBar and TabBarView
        ],
      );
      }),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
    );
  }
}
