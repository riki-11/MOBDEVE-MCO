import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobdeve_mco/controllers/login_controller.dart';
import 'package:mobdeve_mco/pages/register.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/widgets/email_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                children: [
                  EmailFieldWidget(controller: controller.email),
                  const SizedBox(height: 16),
                  PasswordField(
                    controller: controller.password,
                    hintText: 'Password',
                    border: PasswordBorder(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    )
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
                    LoginController.instance.loginUser(
                      controller.email.text.trim(), 
                      controller.password.text.trim());
                  }
               },
                child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    )
                )
            ),
            const SizedBox(height: 16),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'No account yet? ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Sign up.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage())
                          );
                        }
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}
