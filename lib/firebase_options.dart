// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXRnupzuVkBnizPXukb4eZ92R2pxiXm1E',
    appId: '1:562355043888:web:5c355a731c9fb5257777f5',
    messagingSenderId: '562355043888',
    projectId: 'flutter-demo-pdf',
    authDomain: 'flutter-demo-pdf.firebaseapp.com',
    storageBucket: 'flutter-demo-pdf.appspot.com',
    measurementId: 'G-LC4CZV92MP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsdWnWxsEuHRb5jA8mRg6avrThqDZY7D8',
    appId: '1:562355043888:android:0577e4c5b8f645697777f5',
    messagingSenderId: '562355043888',
    projectId: 'flutter-demo-pdf',
    storageBucket: 'flutter-demo-pdf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB00lI-WRdmIvvbprgOIR2Ls7UFHY7pC44',
    appId: '1:562355043888:ios:7b0282c39d16b3577777f5',
    messagingSenderId: '562355043888',
    projectId: 'flutter-demo-pdf',
    storageBucket: 'flutter-demo-pdf.appspot.com',
    iosBundleId: 'com.example.demoPdf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB00lI-WRdmIvvbprgOIR2Ls7UFHY7pC44',
    appId: '1:562355043888:ios:03017c39a746a1e97777f5',
    messagingSenderId: '562355043888',
    projectId: 'flutter-demo-pdf',
    storageBucket: 'flutter-demo-pdf.appspot.com',
    iosBundleId: 'com.example.demoPdf.RunnerTests',
  );
}
