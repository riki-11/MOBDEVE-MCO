import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:passwordfield/passwordfield.dart';

import 'package:mobdeve_mco/authentication/screens/register.dart';
import 'package:mobdeve_mco/pages/homepage.dart';
import 'package:mobdeve_mco/widgets/email_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmailFieldWidget(controller: emailController),
                  const SizedBox(height: 16),
                  PasswordField(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage())
                  );
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