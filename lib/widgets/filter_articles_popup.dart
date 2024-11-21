import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobdeve_mco/controllers/program_controller.dart';
import '../controllers/college_controller.dart';
import '../models/program.dart';
import 'custom_multi_select_container.dart';

class FilterArticlesPopup extends StatefulWidget {
  const FilterArticlesPopup({super.key});

  @override
  State<FilterArticlesPopup> createState() => _FilterArticlesPopupState();
}

class _FilterArticlesPopupState extends State<FilterArticlesPopup> {
  String? selectedCollege;
  String? selectedProgram;
  List<String> programList = [];

  // TODO: Grab the data from the firestore database.
  late Map<String, List<Program>> collegePrograms;
  // late Map<String, List<String>> collegePrograms = {
  //   'CCS': [
  //     'BSCS-ST',
  //     'BS-IT',
  //     'BSCS-NIS',
  //     'BSCS-CSE',
  //     'BSMS-CS',
  //   ],
  //   'GCOE': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  //   'CLA': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  //   'COS': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  //   'COB': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  //   'CLTSOE': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  //   'BAGCED': [
  //     'BSCE',
  //     'BSECE',
  //     'BSME',
  //   ],
  // };

  late List<String> colleges = ['CCS', 'GCOE', 'CLA', 'COS', 'COB', 'CLTSOE', 'BAGCED'];

  @override
  void initState() {
    super.initState();
    selectedCollege = null;
    selectedProgram = null;
    programList = [];
  }

  void updateProgramList(String? college) {
    setState(() {
      selectedCollege = college;
      programList = collegePrograms[college]!.map((program) => program.acronym).toList();
    });
  }

  void updateSelectedProgram(String? program) {
    setState(() {
      selectedProgram = program;
    });
  }

  Future<Map<String, List<Program>>> fetchCollegeList() async {
    ProgramController programController = Get.find();
    Map<String, List<Program>> result = {};

    for(var college in CollegeController.instance.collegeList.value){
      String collegeId = college.id ?? '';
      List<Program> programList = programController.getProgramListFromCollege(collegeId);
      result[college.acronym] = programList;
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

        colleges = snapshot.data?.keys.toList() ?? <String>[];
        collegePrograms = snapshot.data ?? <String, List<Program>>{};
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
                      items: colleges,
                      selectedItem: selectedCollege,
                      label: "College",
                      onChange: (selectedItem) {
                        updateProgramList(selectedItem);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomMultiSelectContainer(
                      items: programList,
                      selectedItem: selectedProgram,
                      label: "Program",
                      onChange: (selectedItem) {
                        updateSelectedProgram(selectedItem);
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
                                    print("selected $selectedCollege, $selectedProgram");

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
