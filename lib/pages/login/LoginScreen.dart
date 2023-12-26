import 'package:demo_pdf/pages/login/GoogleSignIn.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthSignIn authSignIn = AuthSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          width: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Login your account"),
              const SizedBox(
                height: 50,
              ),
              SignInButton(
                Buttons.google,
                onPressed: () {
                  authSignIn.signInWithGoogle();
                  debugPrint('Btn pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
