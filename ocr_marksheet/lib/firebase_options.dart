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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCr3cUzzWPJWeTnRChOXctmYY1Rb75B0fc',
    appId: '1:854474515407:web:0c30cde5e6a619782fe8ba',
    messagingSenderId: '854474515407',
    projectId: 'ocr-marksheet',
    authDomain: 'ocr-marksheet.firebaseapp.com',
    storageBucket: 'ocr-marksheet.appspot.com',
    measurementId: 'G-FPRYDQRF41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn_EQJKTrEqhjAu8Aq-IqmPMxCAnKL7_I',
    appId: '1:854474515407:android:6227be1ec91355a82fe8ba',
    messagingSenderId: '854474515407',
    projectId: 'ocr-marksheet',
    storageBucket: 'ocr-marksheet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDj7R8kRtn_VtX8rj1j2t-6sePnbTBGMyA',
    appId: '1:854474515407:ios:ce6503ecfdae16be2fe8ba',
    messagingSenderId: '854474515407',
    projectId: 'ocr-marksheet',
    storageBucket: 'ocr-marksheet.appspot.com',
    iosBundleId: 'com.example.ocrMarksheet',
  );
}
