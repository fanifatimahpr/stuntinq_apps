import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stuntinq_apps/Splashing/signin_page.dart';

import 'package:stuntinq_apps/Splashing/splashscreen_page.dart';
import 'package:stuntinq_apps/bottomnavigation/bottomnavigation.dart';
import 'package:stuntinq_apps/bottomnavigation/imunisasi.dart';
import 'package:stuntinq_apps/test_data.dart';

void main() {
  runApp(const MyApp());
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
      home: SplashPage(),
    );
  }
}
