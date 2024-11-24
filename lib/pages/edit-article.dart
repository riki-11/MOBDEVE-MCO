import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/article.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/pages/my-profile.dart';
import 'package:mobdeve_mco/widgets/header_plus_textbox.dart';

import '../controllers/article_controller.dart';




class EditArticle extends StatefulWidget {
  final Article article;

  const EditArticle({super.key, required this.article});

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  // TextController for title
  final TextEditingController _titleController = TextEditingController();

  // Initialize Quill controllers
  final QuillController _controllerWYL = QuillController.basic();
  final QuillController _controllerThoughts = QuillController.basic();
  final QuillController _controllerProjects = QuillController.basic();
  final QuillController _controllerTips = QuillController.basic();
  final QuillController _controllerLnR = QuillController.basic();

  // Category-QuillController map
  late Map<String, QuillController> controlMap;

  // Category-FocusNode map
  late Map<String, FocusNode> focusNodes;

  String? activeCategory;

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

    // Initialize focusnodes
    focusNodes = {
      for (var key in controlMap.keys) key: FocusNode()
    };

    // Set focusNode listeners
    focusNodes.forEach((category, focusnode) {
      focusnode.addListener(() {
        setState(() {
          activeCategory = focusnode.hasFocus ? category : null;
        });
      });
    });

  }

  void loadData() {
    _titleController.text = widget.article.title;

    for (var entry in widget.article.content.entries) {
      controlMap[entry.key]?.document = Document.fromJson(jsonDecode(entry.value));
      controlMap[entry.key]?.readOnly = false;
    }
  }

  void updateArticle(bool isPublished) async {
    late String json;
    late Map<String, String> data = {};

    final String title = _titleController.text.toString(); // Article Title

    // Get user data
    var currentUser = UserController.instance.currentUser;
    var college = UserController.instance.currentUserCollege;
    var program = UserController.instance.currentUserProgram;


    for (var entry in widget.article.content.entries) {
      json = jsonEncode(controlMap[entry.key]!.document.toDelta().toJson());
      data[entry.key] = json;
    }

    Article updatedArticle = Article(
        id: widget.article.id!,
        authorId: currentUser.value!.id.toString(),
        title: title,
        content: data,
        datePosted: Timestamp.now(),
        collegeId: college.value!.id.toString(),
        programId: program.value!.id.toString(),
        isPublished: isPublished, // this is default for now, whoops
    );

    if (widget.article.id == null) {
      // Add a new article if no ID exists
      print('Article has no id');
      await ArticleController.instance.addArticle(updatedArticle);
    } else {
      // Update an existing article
      print('Article has id');
      await ArticleController.instance.updateArticle(widget.article.id!, updatedArticle);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.grey.shade700
              ),
            )
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (String value) {
              // Handle the selected value from the dropdown
              if (value == 'draft') {
                updateArticle(false);
                Get.to(() => const MyProfilePage());
              }
              // Add additional actions based on the selection if needed
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'draft',
                child: Text('Save as draft', style: Theme.of(context).textTheme.bodyMedium),
              )
            ],
          ),
          TextButton(
              onPressed: () {
                updateArticle(true);
                Get.to(() => HomePage(controller: ArticleController()));
              },
              child: Text("Update",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary
                  )
              ))
        ],
      ),
      body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      textAlign: TextAlign.left,
                      controller: _titleController,
                      style: Theme.of(context).textTheme.headlineMedium,
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.only(top: 28.0, bottom: 16.0),
                        border: InputBorder.none, // Removes the border
                        hintText: '<TITLE HERE>', // Adds hint text
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      keyboardType: TextInputType.multiline, // Allow multi-line input
                      maxLines: null, // Expands input to wrap text automatically
                    ),

                    // Build Header and textbox options of only the selected categories
                    // .where filters entries that are only true
                    ...widget.article.content.entries.map((entry) {
                      return HeaderPlusTextbox(header: entry.key, controller: controlMap[entry.key], focusNode: focusNodes[entry.key]!);
                    })
                  ],
                ),
              ),
            ),

            if (activeCategory != null)
            // Show toolbar
              Positioned(
                  left: 0,
                  right: 0,
                  child: Material(
                      color: Colors.grey[200],
                      elevation: 5,
                      child: QuillSimpleToolbar(
                          controller: controlMap[activeCategory]!,
                          configurations: const QuillSimpleToolbarConfigurations(
                            toolbarIconAlignment: WrapAlignment.start,
                            showFontFamily: false,
                            showFontSize: false,
                            showBoldButton: true,
                            showItalicButton: true,
                            showUnderLineButton: true,
                            showStrikeThrough: true,
                            showInlineCode: false,
                            showCodeBlock: false,
                            showListNumbers: true,
                            showListBullets: true,
                            showListCheck: false,
                            showHeaderStyle: false,
                            showQuote: true,
                            showIndent: true,
                            showLink: true,
                            showUndo: true,
                            showRedo: true,
                            showBackgroundColorButton: false,
                            multiRowsDisplay: false,
                          )

                      )
                  )
              ),
          ]
      ),
    );
  }

  @override
  void dispose() {

    // Dispose Controllers
    _titleController.dispose();
    _controllerTips.dispose();
    _controllerLnR.dispose();
    _controllerProjects.dispose();
    _controllerWYL.dispose();
    _controllerThoughts.dispose();

    super.dispose();
  }
}
