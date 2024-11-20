import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:passwordfield/passwordfield.dart';


import 'package:mobdeve_mco/widgets/email_field_widget.dart';

import '../../controllers/signup_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();
  // final emailController = TextEditingController();
  // final firstNameController = TextEditingController();
  // final lastNameController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  final controller = Get.put(SignUpController());
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Account'),
        automaticallyImplyLeading: false,
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
                  children: <Widget>[
                    EmailFieldWidget(controller: controller.email),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: controller.firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        ),
                        hintText: 'First Name'
                      )
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: controller.lastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            hintText: 'Last Name'
                        )
                    ),
                    // TODO: Reimplement password field ourselves because font is different
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: controller.password,
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
                      controller: controller.confirmPassword,
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
                  if(_formKey.currentState!.validate()){
                    final email = controller.email.text.trim();
                    final password = controller.password.text.trim();
                    final confirmPassword = controller.confirmPassword.text.trim();
                    final firstName = controller.firstName.text.trim();
                    final lastName = controller.lastName.text.trim();

                    if (password == confirmPassword){
                      SignUpController.instance.registerUser(
                          email,
                          password,
                          firstName,
                          lastName,
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                    }
                  }
                },
                child: Text(
                  'Confirm',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                  )
                )
            )
          ],
        )


      )
    );
  }
}
