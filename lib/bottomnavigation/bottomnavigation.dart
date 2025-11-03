import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Database/dbhelper_user.dart';
import 'package:stuntinq_apps/Model/user_model.dart';
import 'package:stuntinq_apps/bottomnavigation/data.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi.dart';
import 'package:stuntinq_apps/bottomnavigation/imunisasi.dart';
import 'package:stuntinq_apps/bottomnavigation/peta.dart';
import 'package:stuntinq_apps/bottomnavigation/profile.dart';
import 'package:stuntinq_apps/preference_handler.dart';
import 'package:stuntinq_apps/test_listuser_editdelete.dart';

class BottomNavigationApp extends StatefulWidget {
  final UserModel currentUser;
  const BottomNavigationApp({required this.currentUser, Key? key})
    : super(key: key);
  @override
  State<BottomNavigationApp> createState() => _BottomNavigatorAppState();
}

class _BottomNavigatorAppState extends State<BottomNavigationApp> {
  bool clickEye = true;
  bool obscurepass = true;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(UserModel currentUser) => [
    DataPage(),
    ImunisasiPage(),
    EdukasiPage(),
    PetaPage(),
    ProfilePage(user: currentUser), // Mengirim user login
  ];

  void _onItemTapped(int Index) {
    setState(() {
      _selectedIndex = Index;
    });
  }

  //Variabel & Load User untuk Profile
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  void loadCurrentUser() async {
    final id = await PreferenceHandler.getUserId();
    if (id != null) {
      currentUser = await DBHelper.getUserById(id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions(widget.currentUser)[_selectedIndex],
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //Bottom Navigator
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
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Imunisasi",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Edukasi"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Peta"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
// BottomNavigationBarItem bottomNavigationBar(IconData icon, String label, int index) {
//   bool isSelected = index == _selectedIndex;

//   return BottomNavigationBarItem(
//     label: label,
//     icon: Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.blue.withOpacity(0.15) : Colors.transparent,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Icon(
//         icon,
//         size: 28,
//         color: isSelected ? Colors.blue : Colors.green,
//       ),
//     ),
//   );
// }
