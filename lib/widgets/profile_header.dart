import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/models/college.dart';
import 'package:mobdeve_mco/models/program.dart';
import 'package:mobdeve_mco/models/user.dart';
import '../controllers/user_controller.dart';

class ProfileHeader extends StatefulWidget {

  const ProfileHeader({
    super.key,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  User? currentUser;
  College? currentCollege;
  Program? currentProgram;

  @override
  void initState() {
    super.initState();
    // Fetch user, college, and program data on initialization.
    _fetchData();
  }

  void _fetchData() {
    // Fetch current user, college, and program from controllers
    currentUser = UserController.instance.currentUser.value;
    currentCollege = UserController.instance.currentUserCollege.value;
    currentProgram = UserController.instance.currentUserProgram.value;

    // If any of the data is missing, show an error message.
    if (currentUser == null || currentCollege == null || currentProgram == null) {
      Get.snackbar("Error", "Data is missing");
    }

    // Trigger a re-render to update the UI when data is fetched
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator until the data is available
    if (currentUser == null || currentCollege == null || currentProgram == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.account_circle_outlined, size: 64.0),
          // TODO: Replace with display picture.
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    currentUser?.getName() as String,
                    style: Theme.of(context).textTheme.titleLarge,
                    softWrap: true,
                    maxLines: 2,
                  ),
                  Text(
                    "${currentCollege!.name} (${currentCollege!.acronym})",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  Text(
                    "${currentProgram!.name} (${currentProgram!.acronym})",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

