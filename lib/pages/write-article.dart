import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mobdeve_mco/widgets/header_plus_textbox.dart';

// FIXME: Keyboard popup only shows when pressing right under the header.
// FIXME: Text can overflow and user cannot scroll down to continue writing.

class WriteArticle extends StatefulWidget {
  final Map<String, bool> categoryOptions;

  const WriteArticle({super.key, required this.categoryOptions});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {


  final QuillController _controllerWYL = QuillController.basic();
  final QuillController _controllerThoughts = QuillController.basic();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        leading: TextButton(
            onPressed: () { Navigator.pop(context); },
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
                child: Text('Draft', style: Theme.of(context).textTheme.bodyMedium),
                onTap: (){}, // TODO: Implement Draft function
              ),
              PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Add or Edit Topics', style: Theme.of(context).textTheme.bodyMedium),
                onTap: (){}, // TODO: Implement add or Edit Topics
              ),
              PopupMenuItem<String>(
                value: 'Option 3',
                child: Text('Submit to Publication', style: Theme.of(context).textTheme.bodyMedium),
                onTap: (){}, // TODO: Implement Submit to Publication
              ),
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Build Header and textbox options of only the selected categories
            // .where filters entries that are only true
            ...widget.categoryOptions.entries.where((category) => category.value).map((category) {
                return HeaderPlusTextbox(header: category.key);
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    FocusNode().dispose();
    super.dispose();
  }
}
