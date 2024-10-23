import 'package:flutter/material.dart';

import 'package:mobdeve_mco/widgets/email_field_widget.dart';
import 'package:passwordfield/passwordfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EmailFieldWidget(controller: emailController),
                    const SizedBox(height: 16),
                    TextFormField(
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                        hintText: 'First Name'
                      )
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            prefixIcon: const Icon(Icons.person_outline),
                            hintText: 'Last Name'
                        )
                    ),
                    // TODO: Reimplement password field ourselves because font is different
                    const SizedBox(height: 16),
                    PasswordField(
                      hintText: 'Password',
                      border: PasswordBorder(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade200)
                        )
                      ),
                      passwordConstraint: r'^(?=.*\d).+$',
                      errorMessage: 'Must contain at least one digit (0-9)',
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      hintText: 'Confirm Password',
                      border: PasswordBorder(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red.shade200)
                          )
                      ),
                      passwordConstraint: r'^(?=.*\d).+$',
                      errorMessage: 'Must contain at least one digit (0-9)',
                    )
                  ],
                )
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary
                  ),
                ),
                onPressed: () {
                },
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                  )
                ))
          ],
        )


      )
    );
  }
}