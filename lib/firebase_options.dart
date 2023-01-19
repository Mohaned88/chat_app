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
    apiKey: 'AIzaSyCB-SDlApx9JcNmkld5eABocH3FK0_BUXo',
    appId: '1:584414115346:web:36a7c0cffa701341dd4acb',
    messagingSenderId: '584414115346',
    projectId: 'chat22-1edda',
    authDomain: 'chat22-1edda.firebaseapp.com',
    storageBucket: 'chat22-1edda.appspot.com',
    measurementId: 'G-5T95VBM7L5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqnvosO81lMY0rwsnt_F4jseTZWu8-kpA',
    appId: '1:584414115346:android:67af6c362af86921dd4acb',
    messagingSenderId: '584414115346',
    projectId: 'chat22-1edda',
    storageBucket: 'chat22-1edda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQoHTkZaBHxksCgQyyhtFaGWe0CIYyTa0',
    appId: '1:584414115346:ios:15088de5b8a076aedd4acb',
    messagingSenderId: '584414115346',
    projectId: 'chat22-1edda',
    storageBucket: 'chat22-1edda.appspot.com',
    androidClientId: '584414115346-3dvsv854pbm9db8v2tdtrp4a2hbc1dgs.apps.googleusercontent.com',
    iosClientId: '584414115346-c9ea7u16t2sqcfikho2afokcbs9quvl6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQoHTkZaBHxksCgQyyhtFaGWe0CIYyTa0',
    appId: '1:584414115346:ios:15088de5b8a076aedd4acb',
    messagingSenderId: '584414115346',
    projectId: 'chat22-1edda',
    storageBucket: 'chat22-1edda.appspot.com',
    androidClientId: '584414115346-3dvsv854pbm9db8v2tdtrp4a2hbc1dgs.apps.googleusercontent.com',
    iosClientId: '584414115346-c9ea7u16t2sqcfikho2afokcbs9quvl6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
