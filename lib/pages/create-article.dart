import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/checkbox_options.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  Map<String, bool> categoryOptions = {
    "Thoughts":           false,
    "What you'll learn":  false,
    "Projects":           false,
    "Tips for doing well":false,
    "Links and Resources":false
  };

  void handleOptionChange(String option, bool? newValue) {
    setState(() {
      categoryOptions[option] = newValue ?? false;
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

            const Padding(padding: EdgeInsets.only(bottom: 20.0)),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary
                )
              ),
              onPressed: () {}, //TODO: Push Article Edit page
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
