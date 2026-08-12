import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBH29z8pxFd_GMl_UhRekDUjK68_N49-9k',
    appId: '1:487078739019:android:8bf6ea71f36e70f69d21ce',
    messagingSenderId: '487078739019',
    projectId: 'car-rent-app2',
    storageBucket: 'car-rent-app2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASRxK6NF14ehHbT_BQQ3tTKEt7pR3iKZA',
    appId: '1:487078739019:ios:4ba892e27cc564ab9d21ce',
    messagingSenderId: '487078739019',
    projectId: 'car-rent-app2',
    storageBucket: 'car-rent-app2.firebasestorage.app',
    iosBundleId: 'com.example.carRentApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASRxK6NF14ehHbT_BQQ3tTKEt7pR3iKZA',
    appId: '1:487078739019:ios:4ba892e27cc564ab9d21ce',
    messagingSenderId: '487078739019',
    projectId: 'car-rent-app2',
    storageBucket: 'car-rent-app2.firebasestorage.app',
    iosBundleId: 'com.example.carRentApp',
  );
}
