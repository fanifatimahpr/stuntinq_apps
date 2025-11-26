import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/data_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/edukasi_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/imunisasi_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/peta_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/profil_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/service/firebase_service.dart';

class BottomNavFirebase extends StatefulWidget {
  final String currentUserUid;
  const BottomNavFirebase({Key? key, required this.currentUserUid}) : super(key: key);


  @override
  State<BottomNavFirebase> createState() => _BottomNavFirebaseState();
}

class _BottomNavFirebaseState extends State<BottomNavFirebase> {
  int _selectedIndex = 0;
  String? uid; // Menyimpan UID user Firebase
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserUid();
  }

  Future<void> loadUserUid() async {
    final user = await FirebaseService.getCurrentUser();
    if (user != null) {
      uid = user.uid;
    }
    setState(() => isLoading = false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    if (isLoading) {
      return List.generate(5, (index) => const Center(child: CircularProgressIndicator()));
    }

    return [
      DataFirebase(),
      ImunisasiFirebase(),
      EdukasiFirebase(),
      PetaFirebase(),
      ProfileFirebase(uid: widget.currentUserUid), // Kirim UID ke ProfileFirebase
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions()[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Color(0xFF2F6B6A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Data"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Imunisasi"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Edukasi"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Peta"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
