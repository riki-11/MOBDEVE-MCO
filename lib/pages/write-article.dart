import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/constants/global_consts.dart';
import 'package:mobdeve_mco/controllers/user_controller.dart';
import 'package:mobdeve_mco/models/article.dart';
import 'package:mobdeve_mco/models/college.dart';
import 'package:mobdeve_mco/models/program.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/widgets/header_plus_textbox.dart';

import '../controllers/article_controller.dart';

class WriteArticle extends StatefulWidget {
  final Map<String, bool> categoryOptions;

  const WriteArticle({super.key, required this.categoryOptions});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {
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

  }

  void saveArticle() async {
    // TODO: Separate data for each quill controller
    late String json;
    late Map<String, String> data = {};

    final String title = _titleController.text.toString(); // Article Title

    // Get user data
    var currentUser = UserController.instance.currentUser;
    var college = UserController.instance.currentUserCollege;
    var program = UserController.instance.currentUserProgram;


    controlMap.forEach((category, controller) {
      if (controller.document.toPlainText().trim().isNotEmpty) {
        json = jsonEncode(controller.document.toDelta().toJson());
        data[category] = json;
      }
    });

    Article newArticle = Article(
        id: null,
        authorId: currentUser.value!.id.toString(),
        title: title,
        content: data,
        datePosted: Timestamp.now(),
        collegeId: college.value!.id.toString(),
        programId: program.value!.id.toString()
    );

    await ArticleController.instance.addArticle(newArticle);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Make pop-up ensuring user wants to delete draft
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
              print("Selected option: $value");
              // Add additional actions based on the selection if needed
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Save as draft', style: Theme.of(context).textTheme.bodyMedium),
                onTap: (){}, // TODO: Implement Draft function
              )
            ],
          ),
          TextButton(
              onPressed: () {
                saveArticle();
                Get.to(() => HomePage(controller: ArticleController()));
              },
              child: Text("Publish",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  controller: _titleController,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: InputDecoration(
                    border: InputBorder.none, // Removes the border
                    hintText: '<TITLE HERE>', // Adds hint text
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ),

                // Build Header and textbox options of only the selected categories
                // .where filters entries that are only true
                ...widget.categoryOptions.entries.where((category) => category.value).map((category) {
                    return HeaderPlusTextbox(header: category.key, controller: controlMap[category.key],);
                })
              ],
            ),
          ),
        ),
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
