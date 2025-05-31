import 'package:flutter/material.dart';
import 'package:flutter_template/features/auth/domain/constraints.dart';
import 'package:flutter_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_template/packages/core/core.dart';

/// The login view is responsible of taking user input (email and password)
/// and submitting the request to the login use case [LoginUC]
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  String? loginError;

  @override
  Widget build(BuildContext context) {
    final domainConstraints = serviceLocator.get<AuthDomainConstraints>();
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: const ValueKey("login#email"),
            controller: _emailController,
            validator: FormValidation.multi([
              FormValidation.requried("The Email is required"),
              FormValidation.email("Please use a valid email"),
            ]),
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            key: const ValueKey("login#pwd"),
            controller: _passwordController,
            obscureText: true,
            validator: FormValidation.multi([
              FormValidation.requried("The password is required"),
              FormValidation.min(
                "The password is too short",
                minLength: domainConstraints.minPasswordLength,
              ),
            ]),
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton.icon(
            key: const ValueKey("login#submit"),
            onPressed: () {
              if (isLoading) return;
              final valid = _formKey.currentState?.validate() ?? false;
              if (valid) {
                _submitForm();
              }
            },
            icon: isLoading ? const SizedBox.square(dimension: 14, child: CircularProgressIndicator()) : null,
            label: const Text("Login"),
          ),
          if (loginError != null)
            Padding(
              padding: const EdgeInsets.only(
                top: 24.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                loginError!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ),
          /* const SizedBox(
            height: 24,
          ),
          const GoogleSignInButton(), */
        ],
      ),
    );
  }

  void _onLoginFailure(Failure? failure) {
    if (!context.mounted) return;
    String? error = failure?.message;

    if (error != null) {
      showErrorToast(context, error: 'Wrong Credentials 👮');
      setState(() {
        loginError = error;
      });
    }

    FocusScope.of(context).unfocus();
  }

  void _submitForm() async {
    setState(() {
      isLoading = true;
    });

    var failure = await serviceLocator.get<LoginUC>().call(
      (
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );

    _onLoginFailure(failure);

    setState(() {
      isLoading = false;
    });
  }
}
