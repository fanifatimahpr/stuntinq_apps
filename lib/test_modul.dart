import 'package:flutter/material.dart';

class TestModul extends StatefulWidget {
  const TestModul({super.key});

  @override
  State<TestModul> createState() => _TestModulState();
}

class _TestModulState extends State<TestModul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column()));
  }
}
