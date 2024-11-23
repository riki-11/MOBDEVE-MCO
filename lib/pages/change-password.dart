import 'package:flutter/material.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:passwordfield/passwordfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();


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
                    hintText: 'Old password',
                    border: PasswordBorder(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    // TODO: Insert controller
                      hintText: 'New password',
                      border: PasswordBorder(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      )
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    // TODO: Insert controller
                      hintText: 'Confirm new password',
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
                              onPressed: () {
                                // TODO: Insert change password functionality.
                              },
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
}