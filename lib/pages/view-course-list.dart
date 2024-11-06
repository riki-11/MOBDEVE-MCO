import 'package:flutter/material.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
import 'package:mobdeve_mco/pages/write-article.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
class ViewCourseList extends StatefulWidget {
  const ViewCourseList({super.key});

  @override
  State<ViewCourseList> createState() => _ViewCourseListState();
}

class _ViewCourseListState extends State<ViewCourseList> {
  // Currently, these are placeholder values
  Map<String, int> collegeOptions = {
    "CCS":  1,
    "GCOE": 2,
    "COB":  3,
    "CLA":  4,
    "COE":  5,
    "COL":  6,
    "COS":  7,
    "SOE":  8,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose your College"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("What is your college?",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                MultiSelectContainer(
                    maxSelectableCount: 1,
                    itemsDecoration: MultiSelectDecorations(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                        ),
                        selectedDecoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    items: [
                      ...collegeOptions.keys.map((option) {
                        return MultiSelectCard(
                          value: collegeOptions[option]!,
                          label: option,
                        );
                      })
                    ],
                    onChange: (allSelectedItems, selectedItem) {}
                ),

                const Padding(padding: EdgeInsets.only(bottom: 20.0)),

                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Colors.black
                        )
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const CreateArticle())
                      );
                    },
                    child: Text("Next",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary
                      ),
                    ))
              ]
          ),
        )
      ),
    );
  }
}
