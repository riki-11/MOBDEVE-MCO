import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/authentication/authentication_repository.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:passwordfield/passwordfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: 'Change password',
        automaticallyImplyleading: true
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PasswordField(
                    // TODO: Insert controller
                    controller: _oldPasswordController,
                    hintText: 'Old password',
                    // right now, 'old password' has no constraint.
                    // consider adding an error message if it has yet to match the old password.
                    passwordConstraint: r'(.*?)',
                    errorMessage: '',
                    border: PasswordBorder(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    // TODO: Insert controller
                    controller: _newPasswordController,
                    hintText: 'New password',
                    passwordConstraint: r'^(?=.*\d).+$',
                    errorMessage: 'Must contain at least one digit (0-9)',
                    border: PasswordBorder(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    // TODO: Insert controller
                    controller: _confirmNewPasswordController,
                    hintText: 'Confirm new password',
                    passwordConstraint: r'^(?=.*\d).+$',
                    errorMessage: 'Must contain at least one digit (0-9)',
                    border: PasswordBorder(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.primary
                                ),
                              ),
                              onPressed: _changePassword,
                              child: Text(
                                  'Change password',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimary
                                  )
                              )
                          ),
                      )
                    ],
                  ),
                ]
              )
            )
          ]
        )
    )
    );
  }
  Future<void> _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        String oldPassword = _oldPasswordController.text;
        String newPassword = _newPasswordController.text;
        String confirmNewPassword = _confirmNewPasswordController.text;

        if (newPassword != confirmNewPassword) {
          Get.snackbar('Error', 'New password and confirm password do not match.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
          return;
        }

        // Call the method from AuthenticationRepository
        await AuthenticationRepository.instance.changePassword(oldPassword, newPassword);

        // Notify the user
        Get.snackbar("Success", "Password successfully changed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

        // Optionally, navigate away or log out
        // _auth.signOut();
      } catch (e) {
        Get.snackbar("Error", "Error changing password: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      }
    }
  }
}
