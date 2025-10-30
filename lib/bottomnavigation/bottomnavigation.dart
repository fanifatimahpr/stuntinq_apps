
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/bottomnavigation/data.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi.dart';
import 'package:stuntinq_apps/bottomnavigation/imunisasi.dart';
import 'package:stuntinq_apps/bottomnavigation/peta.dart';
import 'package:stuntinq_apps/bottomnavigation/profile.dart';

class BottomNavigatorApp extends StatefulWidget {
  const BottomNavigatorApp({super.key});

  @override
  State<BottomNavigatorApp> createState() => _BottomNavigatorAppState();
}

class _BottomNavigatorAppState extends State<BottomNavigatorApp> {
  bool clickEye = true;
  bool obscurepass = true;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget> [
    DataPage(),
    ImunisasiPage(),
    EdukasiPage(),
    PetaPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int Index){
    setState(() {
      _selectedIndex = Index;
    });
  Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //Bottom Navigator
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Data"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Imunisasi"),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Edukasi"),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: "Peta"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil"),
        ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
      ),
             
      );
  }
}