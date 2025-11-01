import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stuntinq_apps/Database/dbhelper_user.dart';
import 'package:stuntinq_apps/Model/user_model.dart';
import 'package:stuntinq_apps/Splashing/signin_page.dart';
import 'package:stuntinq_apps/Splashing/splashscreen_page.dart';
import 'package:stuntinq_apps/test_listuser_editdelete.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [_buildBackground(), _buildLayer()]),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffD4F2F1),
    );
  }

  Widget _buildLayer() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            _buildHeader(),
            height(20),

            //Informasi Akun (login)
            _buildSectionTitle("Informasi Akun"),
            height(8),
            _buildInfoUserAccount(),

            //Edit Data
            _buildEditBottom(),
            height(15),

            //Pengaturan
            _buildSectionTitle("Pengaturan Akun"),
            height(8),
            _buildSettingsAccount(),
            height(40),

            //Log Out Button
            _buildLogOutButton(
              text: "Log Out",
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashPage()),
                  (route) => false,
                );
              },
            ),
            height(40),

            //App Version
            _buildAppVersion(),
            height(50),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF40E0D0).withOpacity(0.3),
                Color(0xFF2F6B6A).withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.person, color: Color(0xFF2F6B6A), size: 24),
        ),
        width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F6B6A),
              ),
            ),
            Text(
              'Informasi Profil Pengguna',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2F6B6A),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoUserAccount() {
    return Column(
      children: [
        _buildInfoItem(
          icon: Icons.person_outline,
          title: 'Nama Lengkap',
          subtitle: widget.user.fullname ?? '-',
          // subtitle: _userData['name'] ?? '',
          onTap: () {},
        ),
        height(12),
        _buildInfoItem(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: widget.user.email ?? '-',
          // subtitle: _userData['email'] ?? '',
          onTap: () {},
        ),
        height(12),
        _buildInfoItem(
          icon: Icons.phone_outlined,
          title: 'Nomor Telepon',
          subtitle: widget.user.phonenumber ?? '-',
          // subtitle: _userData['phone'] ?? '',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildEditBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => _onEdit(widget.user),
          child: Text(
            "Edit Informasi Akun",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 122, 122, 122),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsAccount() {
    return Column(
      children: [
        _buildInfoItem(
          icon: Icons.notifications_outlined,
          title: 'Notifikasi',
          subtitle: 'Atur pengingat dan pemberitahuan',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildInfoItem(
          icon: Icons.lock_outline,
          title: 'Keamanan',
          subtitle: 'Ubah kata sandi & keamanan akun',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLogOutButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xff2f6b6a), Color(0xff40E0D0)],
        ),
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

  Widget _buildAppVersion() {
    return Center(
      child: Column(
        children: [
          Text(
            'Versi 1.0.0',
            style: TextStyle(
              color: const Color.fromARGB(255, 104, 103, 103),
              fontSize: 12,
            ),
          ),
          height(5),
          Text(
            'Copyright 2025 stuntinQ.',
            style: TextStyle(
              color: const Color.fromARGB(255, 139, 139, 139),
              fontSize: 11,
            ),
          ),
          Text(
            'All right reserved.',
            style: TextStyle(
              color: const Color.fromARGB(255, 139, 139, 139),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF40E0D0).withOpacity(0.2),
                        const Color(0xFF2F6B6A).withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: const Color(0xFF2F6B6A)),
                ),
                const SizedBox(width: 12),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF2F6B6A),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Edit User
  Future<void> _onEdit(UserModel user) async {
    final editFullnameC = TextEditingController(text: user.fullname);
    final editEmailC = TextEditingController(text: user.email);
    final editPhonenumberC = TextEditingController(text: user.phonenumber);
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              buildTextField(
                hintText: "Nama Lengkap",
                controller: editFullnameC,
              ),
              buildTextField(hintText: "Email", controller: editEmailC),
              buildTextField(
                hintText: "Nomor Telepon",
                controller: editPhonenumberC,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updated = UserModel(
        id: user.id,
        fullname: editFullnameC.text,
        email: editEmailC.text,
        phonenumber: editPhonenumberC.text,

        //Contoh jika data integer
        //   age: int.parse(editAgeC.text),
      );
      DBHelper.updateUser(updated);

      setState(() {
        widget.user.fullname = updated.fullname;
        widget.user.email = updated.email;
        widget.user.phonenumber = updated.phonenumber;
      });
      Fluttertoast.showToast(msg: "Data has been updated");
    }
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
