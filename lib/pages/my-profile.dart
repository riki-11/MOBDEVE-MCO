import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mobdeve_mco/controllers/login_controller.dart';
import 'package:mobdeve_mco/pages/settings.dart';
import 'package:mobdeve_mco/widgets/profile_content_dropdown.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/profile_header.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/article_controller.dart';
import '../widgets/article_container_list_view.dart';
import '../widgets/standard_scrollbar.dart';

class MyProfilePage extends StatefulWidget {
  final int pageIndex;
  const MyProfilePage({this.pageIndex = 2, super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  late int pageIndex;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
    _tabController = TabController(length: 2, vsync: this);
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
      body: Column(
        children: <Widget>[
          const ProfileHeader(
            username: "Enrique Lejano",
            collegeName: "College of Computer Studies",
            collegeAcronym: "CCS",
            programName: "BSMS Computer Science Major in Software Technology",
            programAcronym: "BSMS-CS",
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
                      // TODO: Add sharing functionality.
                      onPressed: () async {
                        final result = await Share.share(
                          'Check out my profile at https://medium.com/@rikilejano'
                        );

                        if (result.status == ShareResultStatus.success) {
                          print('Thank you for sharing my website!');
                        }
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const SocialMediaSharingPopup();
                        //     }
                        // );
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
            child: const ProfileContentDropdown(options: ['Articles', 'Lists']),
          ),
          // TabBar and TabBarView
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
                // TODO: Change Firebase query to grab only of that specific user.
                Expanded(
                  child: StandardScrollbar(
                    child: GetX<ArticleController>(
                    init: Get.put<ArticleController>(ArticleController()),
                    builder: (ArticleController articleController) {
                      return ListView.builder(
                          itemCount: articleController.articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("ARTICLE PRINT: ${articleController.articles[index].content}");
                            final articleModel = articleController.articles[index];
                            return ArticleContainerListView(
                                authorId: articleModel.author.id ?? "-1",
                                authorName: articleModel.author.getName(),
                                title: articleModel.title,
                                college: articleModel.college.acronym,
                                date: articleModel.datePosted.toDate(),
                                articleId: articleModel.id ?? "-1",
                                content: articleModel.content,
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
        ],
      ),
      bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
    );
  }
}
