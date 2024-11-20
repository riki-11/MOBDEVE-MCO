import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mobdeve_mco/widgets/header_plus_textbox.dart';

class WriteArticle extends StatefulWidget {
  final Map<String, bool> categoryOptions;

  const WriteArticle({super.key, required this.categoryOptions});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {
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
      "Thoughts":           _controllerThoughts,
      "What you'll learn":  _controllerWYL,
      "Projects":           _controllerProjects,
      "Tips for doing well":_controllerTips,
      "Links and Resources":_controllerLnR
    };

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
              onPressed: (){},
              child: Text("Next",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary
                )
              ))
        ],
      ),

      // TODO: Add edit text for title
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    _controllerTips.dispose();
    _controllerLnR.dispose();
    _controllerProjects.dispose();
    _controllerWYL.dispose();
    _controllerThoughts.dispose();

    super.dispose();
  }
}
