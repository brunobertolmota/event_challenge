//Instância global GetIt
import 'package:event_challenge/app.dart';
import 'package:event_challenge/shared/config/firebase_options.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  //splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //enviroment
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ServiceLocator.initializeDependencies();
}
