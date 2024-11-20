import 'package:flutter/material.dart';
import 'package:mobdeve_mco/pages/write-article.dart';
import 'package:mobdeve_mco/widgets/checkbox_options.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  // Map of article categories
  Map<String, bool> categoryOptions = {
    "Thoughts":           false,
    "What you'll learn":  false,
    "Projects":           false,
    "Tips for doing well":false,
    "Links and Resources":false
  };

  // Variable for error handling
  bool isEmpty = false;

  void handleOptionChange(String option, bool? newValue) {
    setState(() {
      categoryOptions[option] = newValue ?? false;
      hideError();
    });
  }

  void showError() {
    setState(() {
      isEmpty = true;
    });
  }

  void hideError() {
    setState(() {
      isEmpty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Article"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text("What are you writing?",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
                ),
            ),

            ...categoryOptions.keys.map((option) {
              return CheckboxOptions(
                  option: option,
                  value: categoryOptions[option]!,
                  onChange: (newValue) => handleOptionChange(option, newValue));
            }),

            // TODO: Fix error message
            Visibility(visible: isEmpty,child: Text("Error")),

            const Padding(padding: EdgeInsets.only(bottom: 20.0)),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary
                )
              ),
              onPressed: () {
                if (!categoryOptions.values.contains(true)) { // If no option is picked
                  showError();
                  return;
                }

                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WriteArticle(categoryOptions: categoryOptions,))
                );
              }, 
              child: Text("Create",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary
                ),
              ))
          ]
        ),
      ),
    );
  }
}
