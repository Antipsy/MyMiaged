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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      apiKey: "AIzaSyClSkyj90VosspThgDOn0AbaFWoB2c_J0I",
      authDomain: "vinted-clone-336fc.firebaseapp.com",
      projectId: "vinted-clone-336fc",
      storageBucket: "vinted-clone-336fc.appspot.com",
      messagingSenderId: "136366383998",
      appId: "1:136366383998:web:cb1552de03a4f50335892f"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClSkyj90VosspThgDOn0AbaFWoB2c_J0I',
    appId: '1:136366383998:android:1ebb3e7c4d5c646735892f',
    messagingSenderId: '136366383998',
    projectId: 'vinted-clone-336fc',
    storageBucket: "vinted-clone-336fc.appspot.com",
  );
}