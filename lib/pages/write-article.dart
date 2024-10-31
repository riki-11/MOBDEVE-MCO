import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

// FIXME: Keyboard popup only shows when pressing right under the header.
// FIXME: Text can overflow and user cannot scroll down to continue writing.

class WriteArticle extends StatefulWidget {
  const WriteArticle({super.key});

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {


  QuillController _controllerWYL = QuillController.basic();
  QuillController _controllerThoughts = QuillController.basic();

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
              ),
              PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Add or Edit Topics', style: Theme.of(context).textTheme.bodyMedium),
              ),
              PopupMenuItem<String>(
                value: 'Option 3',
                child: Text('Submit to Publication', style: Theme.of(context).textTheme.bodyMedium),
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
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("What You'll Learn",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),

            QuillEditor.basic(
              controller: _controllerWYL,
              configurations: const QuillEditorConfigurations(),
            ),


            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Thoughts",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),

            QuillEditor.basic(
              controller: _controllerThoughts,
              configurations: const QuillEditorConfigurations(),
            ),
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
