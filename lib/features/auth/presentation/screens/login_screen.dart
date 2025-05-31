import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/presentation/views/login_view.dart';

/// A screen that prompts the user to login via email and password
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.checklist,
                size: 100,
              ),
              Column(
                children: [
                  Text(
                    "TODOVER",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Your typical over-engineered todo app 🙄",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: LoginView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
