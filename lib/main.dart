import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stuntinq_apps/Firebase/views/auth/signup_firebase.dart';
import 'package:stuntinq_apps/Firebase/views/auth/splash_firebase.dart';
import 'package:stuntinq_apps/SQFLite/Slicing/splashscreen_page.dart';
import 'package:stuntinq_apps/SQFLite/Slicing/bottomnavigation.dart';
import 'package:stuntinq_apps/SQFLite/main%20page/imunisasi_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stuntinq Apps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: SplashFirebase(),
    );
  }
}
