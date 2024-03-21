import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
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

  static initializeApp() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return await Firebase.initializeApp(options: android);
      case TargetPlatform.iOS:
        return await Firebase.initializeApp();
      default:
        throw Error();
    }
  }

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyAJ_tamN0kjRlwm5OfJeUCDcdMQv4GugrM',
      appId: "1:1095604921798:android:271b8cb1600c3c4a063ec7",
      messagingSenderId: "1095604921798",
      projectId: "smartaudio-b84f1");

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyAJ_tamN0kjRlwm5OfJeUCDcdMQv4GugrM',
      appId: "1:1095604921798:ios:91b471f3a3daefbd063ec7",
      messagingSenderId: "1095604921798",
      projectId: "smartaudio-b84f1");
}

class FirebaseIntialize {}
