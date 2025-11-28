import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stuntinq_apps/SQFLite/Database/user_dbhelper.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/profil_page_firebase.dart';
import 'package:stuntinq_apps/Firebase/service/firebase_service.dart';
import 'package:stuntinq_apps/Firebase/views/auth/bottomnav_firebase.dart';
import 'package:stuntinq_apps/Firebase/views/auth/signup_firebase.dart';
import 'package:stuntinq_apps/SQFLite/Slicing/forgotpassword_page.dart';
import 'package:stuntinq_apps/preference_handler.dart';

class SigninFirebase extends StatefulWidget {
  const SigninFirebase({super.key});

  @override
  State<SigninFirebase> createState() => _SigninFirebaseState();
}

class _SigninFirebaseState extends State<SigninFirebase> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  Widget _buildTextField({
    required String hintText,
    IconData? prefixIcon,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword ? !_showPassword : false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey)
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Color(0xFF2F6B6A), width: 2),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [_buildBackground(), _buildLayer()]));
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffD4F2F1),
    );
  }

  SafeArea _buildLayer() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              //Logo App
              _buildLogoHeader(title: "Sign In"),
              height(55),

              //Form
              //Email
              _buildTextField(
                hintText: 'Email',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email harus diisi";
                  } else if (!value.contains('@')) {
                    return "Email tidak valid";
                  } else if (!RegExp(
                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                  ).hasMatch(value)) {
                    return "Format Email tidak valid";
                  }
                  return null;
                },
              ),

              height(15),

              //Password
              _buildTextField(
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                controller: _passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password harus diisi";
                  } else if (value.length < 6) {
                    return "Password minimal 6 karakter";
                  }
                  return null;
                },
              ),

              height(10),

              //Forgot Password
              // _buildForgotPassword(),

              height(55),

              //Sign In Button
              _buildSigninButton(
                text: "Sign In",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      /// LOGIN KE FIREBASE
                      final result = await FirebaseService.loginUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );

                      if (result == null) {
                        Fluttertoast.showToast(
                          msg: "Email atau password salah",
                          backgroundColor: Colors.red,
                        );
                        return;
                      }

                      /// LOGIN LOCAL DATABASE (opsional)
                      final data = await DBHelper.loginUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      /// SIMPAN STATUS LOGIN
                      await PreferenceHandler.saveLogin(true);

                      if (data != null) {
                        await PreferenceHandler.saveUserId(data.id!);
                      }

                      Fluttertoast.showToast(msg: "Login Successful");

                      /// Panggil ProfileFirebase dengan UID user yang baru login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BottomNavFirebase(currentUserUid: result.uid!,), 
                        ),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Login Failed: $e",
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                },
              ),

              height(30),

              // //Divider
              // Row(
              //   children: const [
              //     Expanded(child: Divider(thickness: 1)),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 15.0),
              //       child: Text(
              //         "Or Sign In With",
              //         style: TextStyle(
              //           fontSize: 13,
              //           color: Color.fromARGB(255, 97, 97, 97),
              //         ),
              //       ),
              //     ),
              //     Expanded(child: Divider(thickness: 1)),
              //   ],
              // ),

              // height(30),

              // // Google Icon
              // Center(
              //   child: Image.asset(
              //     "assets/images/googlelogo.png",
              //     height: 40,
              //     width: 40,
              //   ),
              // ),

              height(25),

              //Dont Have Account
              _buildHaveAccount(
                labelText: "Don't have an account?",
                buttonText: "Sign Up",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupFirebase()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoHeader({required String title}) {
    return Column(
      children: [
        Image.asset('assets/images/Logo StuntinQ.png', height: 80, width: 80),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            color: Color(0xFF2F6B6A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordPage(
                  email: _emailController.text,
                  onBack: () {},
                  onSendOTP: () {},
                ),
              ),
            );
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 97, 97, 97),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSigninButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
     height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
          colors: [Color(0xff2f6b6a), Color(0xff40E0D0)
          ],),
           borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6B6A).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
          ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHaveAccount({
    required String labelText,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 97, 97, 97),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xff2f6b6a),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
