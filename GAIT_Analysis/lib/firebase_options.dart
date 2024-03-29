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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQiTm9M4ZJbzvk17a-U68fLyhr5ra1h-E',
    appId: '1:1096229276091:android:af4af0f959ea1cbd911c9e',
    messagingSenderId: '1096229276091',
    projectId: 'gait-analysis-8a05a',
    databaseURL: 'https://gait-analysis-8a05a-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gait-analysis-8a05a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAE56V1aWugBtCasXWNUd84ghhJxeKY1fY',
    appId: '1:1096229276091:ios:267cf7e1b9a7d50c911c9e',
    messagingSenderId: '1096229276091',
    projectId: 'gait-analysis-8a05a',
    databaseURL: 'https://gait-analysis-8a05a-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gait-analysis-8a05a.appspot.com',
    iosClientId: '1096229276091-24up40oqvhltf2cd3jb23c6lq8rjmcu7.apps.googleusercontent.com',
    iosBundleId: 'com.example.gaitAnalysis',
  );
}
