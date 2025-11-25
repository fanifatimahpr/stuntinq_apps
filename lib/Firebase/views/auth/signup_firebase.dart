import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stuntinq_apps/Database/user_dbhelper.dart';
import 'package:stuntinq_apps/Firebase/models/user_firebase_model.dart';
import 'package:stuntinq_apps/Firebase/service/user_firebase_service.dart';
import 'package:stuntinq_apps/Firebase/views/auth/signin_firebase.dart';
import 'package:stuntinq_apps/Model/user_model.dart';

class SignupFirebase extends StatefulWidget {
  const SignupFirebase({super.key});

  @override
  State<SignupFirebase> createState() => _SignupFirebaseState();
}

class _SignupFirebaseState extends State<SignupFirebase> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserFirebaseModel user = UserFirebaseModel();
  bool _showPassword = false;

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    IconData? prefixIcon,
    bool isPassword = false,
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
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: Color(0xFF2F6B6A), width: 2),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_buildBackground(), _buildLayer(context)]),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffD4F2F1),
    );
  }

  Widget _buildLayer(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),

              //Logo App
              _buildLogoHeader(title: "Sign Up"),

              height(25),

              //Form
              //Full Name
              _buildTextField(
                hintText: "Full Name",
                controller: _fullnameController,
                prefixIcon: Icons.person_outline,
                validator: (val) => val!.isEmpty ? "Name must be filled" : null,
              ),
              height(15),

              //Phone
              _buildTextField(
                hintText: "Phone Number",
                controller: _phoneController,
                prefixIcon: Icons.phone_outlined,
                validator: (val) =>
                    val!.isEmpty ? "Phone number must be filled" : null,
              ),
              height(15),

              //Email
              _buildTextField(
                hintText: "Email",
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Email must be filled";
                  if (!RegExp(
                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                  ).hasMatch(value)) {
                    return "Email not valid";
                  }
                  return null;
                },
              ),
              height(15),
              //Password
              _buildTextField(
                hintText: "Password",
                controller: _passwordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return "Password must be filled";
                  if (val.length < 6) return "Minimum 6 characters";
                  return null;
                },
              ),

              height(35),

              //Sign Up Button
              _buildSignUpButton(
                text: "Sign Up",
                onPressed: () {
                  print("Sign Up Succesful");
                },
              ),

              height(25),

              //Divider
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Or Sign Up With",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),

              height(30),

              // Google Button (image)
              Image.asset("assets/images/googlelogo.png", height: 40),

              SizedBox(height: 25),

              // Have an account
              _buildHaveAccount(
                labelText: "Already have an account?",
                buttonText: "Sign In",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SigninFirebase()),
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

  Widget _buildSignUpButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2f6b6a), Color(0xff40E0D0)],
        ),
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
        onPressed: () async {
  if (_formKey.currentState!.validate()) {
    try {
      // REGISTER KE FIREBASE
      final result = await FirebaseService.registerUser(
        email: _emailController.text.trim(),
        fullname: _fullnameController.text.trim(),
        phonenumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );

      setState(() {
        user = result; // simpan user Firebase
      });

      // SIMPAN KE DATABASE LOKAL (SQLite)
      final UserModel data = UserModel(
        fullname: _fullnameController.text,
        phonenumber: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      await DBHelper.registerUser(data);

      Fluttertoast.showToast(msg: "Sign Up Successful");

      // KEMBALI KE LOGIN PAGE
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Registration failed: $e",
        backgroundColor: Colors.red,
      );
    }
  }
},

        // onPressed: () {
        //   if (_formKey.currentState!.validate()) {
        //     final UserModel data = UserModel(
        //       fullname: _fullnameController.text,
        //       phonenumber: _phoneController.text,
        //       email: _emailController.text,
        //       password: _passwordController.text,
        //     );
        //     DBHelper.registerUser(data);
        //     Fluttertoast.showToast(msg: "Sign Up Successful");
        //     Navigator.pop(context);
        //   } else {}
        // },
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

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
