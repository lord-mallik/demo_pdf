import 'dart:io';

import 'package:demo_pdf/pages/Email/smtpServerConnection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as ga;

class AuthSignIn {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope(ga.DriveApi.driveFileScope);

      try {
        await FirebaseAuth.instance.signInWithRedirect(googleProvider);
        final credential = await FirebaseAuth.instance.getRedirectResult();

        return credential;
      } catch (e) {
        debugPrint('Error signing in with Google: $e');
        rethrow;
      }
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    }
  }


  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> getAccessToken() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
final accessToken = googleSignInAuthentication.accessToken;
      return accessToken;
    } catch (error) {
      print('Error getting access token: $error');
      return null;
    }
  }
}
// ignore_for_file: avoid_print



