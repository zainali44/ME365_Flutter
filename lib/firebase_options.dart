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
    apiKey: 'AIzaSyBygUG2cu_w3JfnSYmBMUrH0pRhribMTzY',
    appId: '1:833735737192:web:672ed42651d4e09c7b60dd',
    messagingSenderId: '833735737192',
    projectId: 'me365-81633',
    authDomain: 'me365-81633.firebaseapp.com',
    storageBucket: 'me365-81633.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCibsC1usmURtV5ZVF8117vbUvNNP3g8jg',
    appId: '1:833735737192:android:dc3ffc8e9fa07c5a7b60dd',
    messagingSenderId: '833735737192',
    projectId: 'me365-81633',
    storageBucket: 'me365-81633.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7QX5FmubE2MwUEXAPxGLLokZuA4ye9zI',
    appId: '1:833735737192:ios:0924b4303bed4a667b60dd',
    messagingSenderId: '833735737192',
    projectId: 'me365-81633',
    storageBucket: 'me365-81633.appspot.com',
    iosBundleId: 'com.example.testproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7QX5FmubE2MwUEXAPxGLLokZuA4ye9zI',
    appId: '1:833735737192:ios:cdc9370269625e9b7b60dd',
    messagingSenderId: '833735737192',
    projectId: 'me365-81633',
    storageBucket: 'me365-81633.appspot.com',
    iosBundleId: 'com.example.testproject.RunnerTests',
  );
}
