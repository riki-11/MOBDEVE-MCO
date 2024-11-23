import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/pages/edit-article.dart';


import 'package:mobdeve_mco/widgets/article_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/delete_dialogue.dart';
import 'package:mobdeve_mco/widgets/social_media_sharing_popup.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';
import 'package:mobdeve_mco/widgets/disappearing_top_bar.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/global_consts.dart';
import '../controllers/college_controller.dart';
import '../controllers/program_controller.dart';
import '../controllers/user_controller.dart';
import '../models/article.dart';
import '../models/college.dart';
import '../models/program.dart';
import '../models/user.dart';

class ViewArticle extends StatefulWidget {
  final Article article;
  const ViewArticle({super.key, required this.article});

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {

  // Initialize Quill controllers
  final QuillController _controllerWYL = QuillController.basic();
  final QuillController _controllerThoughts = QuillController.basic();
  final QuillController _controllerProjects = QuillController.basic();
  final QuillController _controllerTips = QuillController.basic();
  final QuillController _controllerLnR = QuillController.basic();

  // Category-QuillController map
  late Map<String, QuillController> controlMap;

  // Bool variables
  bool isAuthor = false;
  bool showBottomBar = true;

  // User variables
  late College college;
  late Program program;
  late User author;

  // Formatted variables for link-sharing
  late String formattedTitle;
  late String formattedAuthorName;

  @override
  void initState() {
    super.initState();
    // Configure controller map
    controlMap = {
      HEADER_THOUGHTS:  _controllerThoughts,
      HEADER_WYL:       _controllerWYL,
      HEADER_PROJECTS:  _controllerProjects,
      HEADER_TIPS:      _controllerTips,
      HEADER_LNR:       _controllerLnR
    };

    loadData();
    checkUserisAuthor();
  }

  void loadData() {
    for (var entry in widget.article.content.entries) {
      controlMap[entry.key]?.document = Document.fromJson(jsonDecode(entry.value));
      controlMap[entry.key]?.readOnly = true;
    }
  }

  void deleteArticle() async {
    var articleId = widget.article.id;

    if (articleId == null) {
      // TODO: Display error (?)

      return;
    }
    await ArticleController.instance.deleteArticle(widget.article.id.toString());
  }

  void checkUserisAuthor() {
    // Check if user is author

    var currentUser = UserController.instance.currentUser.value!.id;
    var articleAuthor = widget.article.authorId;

    if (currentUser == articleAuthor) {
      setState(() {
        isAuthor = true;
      });
    }
  }

  Future<Map<String, dynamic>> fetchCollegeAndAuthor() async {
    // college = await CollegeController.instance.getCollege(widget.article.collegeId);
    college = CollegeController.instance.collegeList.value.firstWhere(
            (college) => college.id == widget.article.collegeId,
        orElse: () => throw Exception("College not Found"));
    program =
    await ProgramController.instance.getProgram(widget.article.programId);
    author = await UserController.instance.getUserData(widget.article.authorId);
    return {'college': college, 'program': program, 'author': author};
  }
  void onScroll(Notification notif) {
    if (notif is UserScrollNotification) {
      final scrollDirection = notif.direction;
      if (scrollDirection == ScrollDirection.reverse && showBottomBar) {
        setState(() {showBottomBar = false;});
      } else if (scrollDirection == ScrollDirection.forward && !showBottomBar) {
        setState(() {showBottomBar = true;});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCollegeAndAuthor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle error state
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          // Handle the case where there's no data
          return const Center(child: Text('No data available'));
        }

        return Scaffold(
          body: DisappearingTopBar(
              actions: [
                IconButton(
                  onPressed: () async {
                    formattedTitle = widget.article.title.toLowerCase().replaceAll(RegExp(r'\s+'), '-');
                    formattedAuthorName = author.getName().toLowerCase().replaceAll(RegExp(r'\s+'), '-');
                    final result = await Share.share(
                      'Read "${widget.article.title}", an article by ${author.getName()}, at https://uniguide.com/$formattedAuthorName/$formattedTitle.'
                    );
                  },
                  icon: const Icon(Icons.ios_share_rounded)),
                PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz),
                    onSelected: (String value) {
                      print("Selected option: $value");
                      if (value == 'edit-article') {
                        Get.to(() => EditArticle(article: widget.article));
                      }
                      if (value == 'delete-article') {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialogue(
                              deleteFunction: deleteArticle,
                            );
                          },
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'report-article',
                        child: Text('Report article', style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      if (isAuthor)
                        PopupMenuItem<String> (
                          value: 'edit-article',
                          child: Text('Edit article',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ),
                      if (isAuthor)
                        PopupMenuItem<String> (
                          value: 'delete-article',
                            child: Text('Delete article',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)
                            )
                        )
                    ]
                ),
              ],
              body: NotificationListener<UserScrollNotification>(
                onNotification: (notif) {
                  onScroll(notif);
                  return true;
                },
                child: StandardScrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                              "This is a short description of the article",
                              style: Theme.of(context).textTheme.bodyLarge
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      author.getName(),
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w600
                                      )
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(widget.article.datePosted.toDate()),
                                    style: Theme.of(context).textTheme.bodySmall
                                  ),
                                ],
                              ),
                              const Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.account_circle_rounded)
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 32.0), // Spacing between title and content
                          ...widget.article.content.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key, // Section title
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 8.0),
                                  QuillEditor.basic(
                                    controller: controlMap[entry.key],
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    )
                ),
              )
          ),
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showBottomBar ? kBottomNavigationBarHeight : 0.0,
            child: ArticleBottomBar(
              articleId: widget.article.id!,
            ),
          )
        );
      }
    );
  }

  @override
  void dispose() {
    for (var entry in controlMap.entries) {
      controlMap[entry.key]?.dispose();
    }
    super.dispose();
  }
}


