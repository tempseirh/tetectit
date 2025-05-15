import 'package:detect_it/init.dart';
import 'package:detect_it/utils/hooks/firebase_options.dart';
import 'package:detect_it/utils/hooks/use_emulator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await useEmulator(useEmulator: false, host: '197.159.140.9');

  await GetStorage.init();

  configLoading();
  runApp(const MainApp());
}
