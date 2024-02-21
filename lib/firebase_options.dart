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
    apiKey: 'AIzaSyBNUqw2EcbIktgQSKG8X1Cnjx1SaQFLmuc',
    appId: '1:503890800196:web:3501736d86d1dbe9465611',
    messagingSenderId: '503890800196',
    projectId: 'providerapp-4a41b',
    authDomain: 'providerapp-4a41b.firebaseapp.com',
    storageBucket: 'providerapp-4a41b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMoI23Pbxptwnsoyv08kRE_-JBbdn-j68',
    appId: '1:503890800196:android:ba79370721c56e78465611',
    messagingSenderId: '503890800196',
    projectId: 'providerapp-4a41b',
    storageBucket: 'providerapp-4a41b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUOZeShRn7nBT5-GD_GmWmUsCqyFSRFn0',
    appId: '1:503890800196:ios:1f16dcec52b60907465611',
    messagingSenderId: '503890800196',
    projectId: 'providerapp-4a41b',
    storageBucket: 'providerapp-4a41b.appspot.com',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUOZeShRn7nBT5-GD_GmWmUsCqyFSRFn0',
    appId: '1:503890800196:ios:6d1b98575297998e465611',
    messagingSenderId: '503890800196',
    projectId: 'providerapp-4a41b',
    storageBucket: 'providerapp-4a41b.appspot.com',
    iosBundleId: 'com.example.firebaseapp.RunnerTests',
  );
}