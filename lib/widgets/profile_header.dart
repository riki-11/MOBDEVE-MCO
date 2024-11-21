import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';

import '../controllers/user_controller.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String collegeName;
  final String collegeAcronym;
  final String programName;
  final String programAcronym;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.collegeName,
    required this.collegeAcronym,
    required this.programName,
    required this.programAcronym
  });

  // User user = await UserController.getUserData(AuthenticationRepository.instance.firebaseUser.value!.uid);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child:
          Obx(()
              {
                UserController controller = UserController.instance;
                var user = controller.currentUser.value;
                var userCollege = controller.currentUserCollege.value;
                var userProgram = controller.currentUserProgram.value;
                if(user == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.account_circle_outlined, size: 64.0), // TODO: Replace with display picture.
                      Flexible( // Allow the text content to take only the required space
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  user.getName(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                  softWrap: true, // Enable wrapping
                                  maxLines: 2, // Optionally limit to 2 lines
                                ),
                                Text(
                                  "${userCollege?.name} (${userCollege?.acronym})",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  softWrap: true,
                                ),
                                Text(
                                  "${userProgram?.name} (${userProgram?.acronym})",
                                  style: Theme.of(context).textTheme.bodySmall,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          )
                      )
                    ]
                );
              }
          ),

    );
  }
}