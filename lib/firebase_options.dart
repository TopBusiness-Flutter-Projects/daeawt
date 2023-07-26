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
    apiKey: 'AIzaSyDQBq8hT_QFDA98IPb6T6kj93TJwKkMqMk',
    appId: '1:187798023388:web:d920d8a114145a1f585819',
    messagingSenderId: '187798023388',
    projectId: 'dawat-e6490',
    authDomain: 'dawat-e6490.firebaseapp.com',
    storageBucket: 'dawat-e6490.appspot.com',
    measurementId: 'G-RE1G5BXYM6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMKM_vmKi2H_ysXB_eEorpx0IilnrzY0w',
    appId: '1:187798023388:android:53c6d71907a8e22a585819',
    messagingSenderId: '187798023388',
    projectId: 'dawat-e6490',
    storageBucket: 'dawat-e6490.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR2GT0Y3QGS2j_JYx-pLPWSf97S0D-PJk',
    appId: '1:187798023388:ios:9b643732975e235b585819',
    messagingSenderId: '187798023388',
    projectId: 'dawat-e6490',
    storageBucket: 'dawat-e6490.appspot.com',
    iosClientId: '187798023388-cua5icrubet7f75jj4vfe15ppfvj5pbg.apps.googleusercontent.com',
    iosBundleId: 'com.topbusiness.daeawt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDR2GT0Y3QGS2j_JYx-pLPWSf97S0D-PJk',
    appId: '1:187798023388:ios:d90f667e9ea65c4d585819',
    messagingSenderId: '187798023388',
    projectId: 'dawat-e6490',
    storageBucket: 'dawat-e6490.appspot.com',
    iosClientId: '187798023388-kfuk3iknko4o5qubl3qf430fjcprvfea.apps.googleusercontent.com',
    iosBundleId: 'com.topbusiness.daeawt.RunnerTests',
  );
}