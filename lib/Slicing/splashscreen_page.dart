import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stuntinq_apps/Database/user_dbhelper.dart';
import 'package:stuntinq_apps/Model/user_model.dart';
import 'package:stuntinq_apps/Slicing/signin_page.dart';
import 'package:stuntinq_apps/preference_handler.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    isLoginFunction();
  }


      //Jika sudah ada user id namun harus ke sign in lagi
      isLoginFunction() async {
  await Future.delayed(const Duration(seconds: 3)).then((value) async {
    bool? isLogin = await PreferenceHandler.getLogin();
    int? userId = await PreferenceHandler.getUserId();

    
  if (!mounted) return;

  print("DEBUG: isLogin=$isLogin, userId=$userId"); // untuk cek nilai

  if (isLogin == true && userId != null) {
    // Sudah login, arahkan ke home (nanti ganti sesuai app kamu)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninPage()),
      // ganti SigninPage() jadi BottomNavigationApp(currentUser: user)
    );
  } else {
    // Belum login → ke SigninPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninPage()),
    );
  }
}
);
}

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff2F6B6A), Color(0xff40E0D0)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/Logo StuntinQ.png',
                height: 160,
                width: 160,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "StuntinQ",
              style: TextStyle(
                color: Color(0xff2F6B6A),
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
