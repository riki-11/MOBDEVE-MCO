import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/pages/change-password.dart';

import '../authentication/authentication_repository.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Change password'),
            onTap: () {
              Get.to(
                // TODO: Insert arguments for current user as necessary.
                const ChangePasswordPage()
              );
            }
          ),
          ListTile(
            title: const Text('Log Out'),
            textColor: Colors.red,
            onTap: () {
              Get.find<AuthenticationRepository>().logout();
              // Closes the bottom sheet
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}