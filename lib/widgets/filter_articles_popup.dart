import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/controllers/article_controller.dart';
import 'package:mobdeve_mco/controllers/program_controller.dart';
import 'package:mobdeve_mco/models/college.dart';
import '../controllers/college_controller.dart';
import '../models/program.dart';
import 'custom_multi_select_container.dart';

class FilterArticlesPopup extends StatefulWidget {
  const FilterArticlesPopup({super.key});

  @override
  State<FilterArticlesPopup> createState() => _FilterArticlesPopupState();
}

class _FilterArticlesPopupState extends State<FilterArticlesPopup> {
  College? selectedCollege;
  Program? selectedProgram;
  List<Program> programList = [];

  // TODO: Grab the data from the firestore database.
  late Map<College, List<Program>> collegePrograms;

  late List<College> colleges = [];

  @override
  void initState() {
    super.initState();

    // Initialize selectedCollege and selectedProgram from ArticleController
    final articleController = ArticleController.instance;
    selectedCollege = articleController.collegeFilter.value;
    selectedProgram = articleController.programFilter.value;

    print("INIT FILTERS: $selectedProgram $selectedCollege");
    // Initialize programList if selectedCollege is not null
  }
  void updateProgramList(College? college) {
    setState(() {
      selectedCollege = college;
      programList = collegePrograms[college]!.map((program) => program).toList();
    });
  }

  void updateSelectedProgram(Program? program) {
    setState(() {
      selectedProgram = program;
    });
  }

  Future<Map<College, List<Program>>> fetchCollegeList() async {
    ProgramController programController = Get.find();
    Map<College, List<Program>> result = {};

    for(var college in CollegeController.instance.collegeList.value){
      String collegeId = college.id ?? '';
      List<Program> programList = programController.getProgramListFromCollege(collegeId);
      result[college] = programList;
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCollegeList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching data
          // return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle error state
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          // Handle the case where there's no data
          return const Center(child: Text('No data available'));
        }

        colleges = snapshot.data?.keys.toList() ?? <College>[];
        collegePrograms = snapshot.data ?? <College, List<Program>>{};
        return SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 10,
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomMultiSelectContainer(
                      items: colleges.map((college) => college.acronym).toList(),
                      selectedItem: selectedCollege?.acronym,
                      label: "College",
                      onChange: (selectedItem) {
                        updateProgramList(selectedItem != null ? 
                          colleges.firstWhere((college) => college.acronym == selectedItem) 
                          : null);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomMultiSelectContainer(
                      items: programList.map((program) => program.acronym).toList(),
                      selectedItem: selectedProgram?.acronym,
                      label: "Program",
                      onChange: (selectedItem) {
                        updateSelectedProgram(selectedItem != null ? programList.firstWhere((program) => program.acronym == selectedItem) : null);
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(
                                    color: Colors.black12,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedCollege = null;
                                    programList = [];
                                  });
                                },
                                child: Text(
                                  "Clear",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: Apply filter and close popup.
                                    // Set the obs of both college and program in ArticleController
                                    ArticleController.instance.collegeFilter.value = selectedCollege;
                                    ArticleController.instance.programFilter.value = selectedProgram;

                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    "Apply",
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ]
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
