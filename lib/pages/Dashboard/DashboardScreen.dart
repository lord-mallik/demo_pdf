import 'package:demo_pdf/pages/Email/EmailSending.dart';
import 'package:demo_pdf/pages/login/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Email/EmailSend.dart';
import '../login/GoogleSignIn.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final user = FirebaseAuth.instance.currentUser;
  AuthSignIn authSignIn = AuthSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(user!.email!),
            const SizedBox(
              height: 20,
            ),
            Text(user!.displayName!),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {

                debugPrint("Email Send");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  EmailSend()),
                );
              },
              child: const Text('Email Send'),
            ), const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                authSignIn.signOutUser();
                debugPrint("Sign Out");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Log Out'),
            ),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
