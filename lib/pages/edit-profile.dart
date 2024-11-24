import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/program_controller.dart';
import '../controllers/article_controller.dart';
import '../controllers/college_controller.dart';
import '../models/college.dart';
import '../models/program.dart';
import '../widgets/standard_app_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  College? selectedCollege;
  Program? selectedProgram;
  String? selectedCollegeId;
  List<Program> programList = [];

  String? selectedProgramId;
  final CollegeController collegeController = Get.put(CollegeController());
  final ProgramController programController = Get.put(ProgramController());

  // Map to store programs by college id
  late Map<College, List<Program>> collegePrograms;
  late List<College> colleges = [];

  @override
  void initState() {
    super.initState();

    final articleController = ArticleController.instance;
    selectedCollege = articleController.collegeFilter.value;
    selectedProgram = articleController.programFilter.value;
  }

  void updateProgramList(String? collegeId) {
    setState(() {
      selectedCollegeId = collegeId;
      if (collegeId != null && collegeId.isNotEmpty) {
        programList = programController.getProgramListFromCollege(collegeId);
        selectedProgramId = null; // Reset the selected program
      } else {
        programList = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: 'Edit Profile',
        automaticallyImplyleading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: 'First Name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: 'Last Name',
                ),
              ),
              const SizedBox(height: 16),
              // College Dropdown
              if (collegeController.collegeList.value.isEmpty)
                const Center(child: CircularProgressIndicator())
              else
                DropdownButtonFormField<String>(
                  value: selectedCollegeId,
                  items: collegeController.collegeList.value.map((college) {
                    return DropdownMenuItem<String>(
                      value: college.id,
                      child: Text(college.acronym),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    updateProgramList(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'College',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your college';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              // Program Dropdown
              DropdownButtonFormField<String>(
                value: selectedProgramId,
                items: programList.isEmpty
                    ? []
                    : programList.map((program) {
                  return DropdownMenuItem<String>(
                    value: program.id,
                    child: Text(program.acronym),
                  );
                }).toList(),
                onChanged: selectedCollegeId == null
                    ? null
                    : (String? value) {
                  setState(() {
                    selectedProgramId = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Program',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your program';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Edit Profile Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Edit profile according to form.
                  },
                  child: Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
