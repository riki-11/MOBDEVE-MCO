import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/college_controller.dart';
import 'package:mobdeve_mco/controllers/program_controller.dart';
import 'package:mobdeve_mco/models/program.dart';
import 'package:mobdeve_mco/pages/create-article.dart';
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

  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose your Program"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("What is your course?",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                GetX<ProgramController>(
                  init: Get.put<ProgramController>(ProgramController()),
                  builder: (ProgramController controller) {
                    var collegeId = data['collegeId'];
                    var programsUnderCollege = controller.getProgramListFromCollege(collegeId);
                    if (programsUnderCollege.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return MultiSelectContainer(
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
                          ...programsUnderCollege.map((college){
                            print("PROGRAM: ${college.acronym}");
                            return MultiSelectCard(
                              value: college.id,
                              label: college.acronym,
                            );
                          })
                        ],
                        onChange: (allSelectedItems, selectedItem){
                          print("Selected College: $selectedItem");
                        }
                    );

                },),
                const Padding(padding: EdgeInsets.only(bottom: 20.0)),

                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            Colors.black
                        )
                    ),
                    onPressed: () {
                      Get.to(CreateArticle());
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
