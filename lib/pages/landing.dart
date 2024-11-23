import 'package:flutter/material.dart';

import 'package:mobdeve_mco/pages/login.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center widget ensures the text is centered on the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to UniGuide',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Your number one resource for\n',
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    TextSpan(
                      text: 'winning at university.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold
                      )
                    )
                  ]
                )
              )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary
                ),
                elevation: WidgetStateProperty.all(8.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
              child: Text(
                  'Get started',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

}