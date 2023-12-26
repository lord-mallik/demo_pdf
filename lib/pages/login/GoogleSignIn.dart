import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSignIn {
  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {

      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Add necessary scopes for Google Drive access
      googleProvider.addScope('https://www.googleapis.com/auth/drive');

      try {
        // Use signInWithRedirect for a better user experience, especially on web
        await FirebaseAuth.instance.signInWithRedirect(googleProvider);
        final credential = await FirebaseAuth.instance.getRedirectResult();
        // Retrieve the result after the redirect
        return credential;
      } catch (e) {
        // Handle sign-in error
        debugPrint('Error signing in with Google: $e');
        rethrow;
      }
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
