import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stuntinq_apps/Database/dbhelper_user.dart';
import 'package:stuntinq_apps/Model/user_model.dart';
import 'package:stuntinq_apps/Slashingg/signin_page.dart';
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

  isLoginFunction() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) async {
      bool? isLogin = await PreferenceHandler.getLogin();
      int? userId = await PreferenceHandler.getUserId(); //get user ID (login)

      //Jika sudah ada user id langsung ke bottom navigation
      //  if (isLogin == true && userId != null) {
      //   UserModel? user = await DBHelper.getUserById(userId);

      //   if (user != null) {
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => BottomNavigationApp(currentUser: user),
      //       ),
      //       (route) => false,
      //     );
      //     return;
      //

      //Jika sudah ada user id namun harus ke sign in lagi
      if (isLogin == true && userId != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SigninPage()),
          // (route) => false,
        );
      }
    });
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
