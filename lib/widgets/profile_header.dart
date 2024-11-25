
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return Obx(() {
      // Show loading indicator until all data is available
      if (userController.currentUser.value == null ||
          userController.currentUserCollege.value == null ||
          userController.currentUserProgram.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final user = userController.currentUser.value!;
      final college = userController.currentUserCollege.value!;
      final program = userController.currentUserProgram.value!;

      return Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.account_circle_outlined, size: 64.0),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.getName(),
                      style: Theme.of(context).textTheme.titleLarge,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      "${college.name} (${college.acronym})",
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                    Text(
                      "${program.name} (${program.acronym})",
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
    });
  }
}
