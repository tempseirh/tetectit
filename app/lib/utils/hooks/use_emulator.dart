import 'package:detect_it/library/detect_it.dart';

Future<void> useEmulator({bool useEmulator = false, String? host}) async {
  if (useEmulator) {
    FirebaseAuth.instance.useAuthEmulator(host ?? 'localhost', 9099);
    FirebaseStorage.instance.useStorageEmulator(host ?? 'localhost', 9199);
    FirebaseFirestore.instance.useFirestoreEmulator(host ?? 'localhost', 8081);
    return;
  }

  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.appAttest,
  // );

  FlutterError.onError = (errorDetails) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
}
