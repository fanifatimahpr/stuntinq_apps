import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stuntinq_apps/Database/dbhelper_user.dart';
import 'package:stuntinq_apps/Model/user_model.dart';
import 'package:stuntinq_apps/Splashing/signin_page.dart';
import 'package:stuntinq_apps/Splashing/splashscreen_page.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header
          _buildHeader(),
          height(20),

          //List Info Akun
          _buildSectionTitle("Informasi Akun"),
          height(8),
          _buildInfoUserAccount(),

          //Edit TextButton
          _buildEditBottom(),
          height(15),

          //Pengaturan
          _buildSectionTitle("Pengaturan Akun"),
          height(8),
          _buildSettingsAccount(),
          height(40),

          //Log Out
          _buildLogOutButton(
            text: "Log Out",
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashPage()),
                (route) => false,
              );
            },
          ),

          height(15),

          //Delete Acc
          _buildDeleteAccountButton(),
          height(40),

          //App Version
          _buildAppVersion(),
          height(50),
        ],
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
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF2F6B6A),
        fontSize: 15,
        fontWeight: FontWeight.w600,
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
          onTap: () {},
        ),
        height(12),
        _buildInfoItem(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: widget.user.email ?? '-',
          onTap: () {},
        ),
        height(12),
        _buildInfoItem(
          icon: Icons.phone_outlined,
          title: 'Nomor Telepon',
          subtitle: widget.user.phonenumber ?? '-',
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
        gradient: const LinearGradient(
          colors: [Color(0xff2f6b6a), Color(0xff40E0D0)],
        ),
        borderRadius: BorderRadius.circular(26),
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

  Widget _buildDeleteAccountButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.red.withOpacity(0.2), width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text(
                  "Hapus Akun?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: const Text(
                  "Apakah kamu yakin ingin menghapus akun ini? Semua data akan hilang permanen.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog
                    },
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      final db = DBHelper();
                      await DBHelper.deleteUser(widget.user.id!);

                      Navigator.pop(context); // Tutup dialog

                      Fluttertoast.showToast(
                        msg: "Akun berhasil dihapus",
                        gravity: ToastGravity.BOTTOM,
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashPage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Hapus",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete, color: Colors.red),
            width(10),
            Text(
              "Hapus Akun",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          height(5),
          Text(
            'Copyright 2025 stuntinQ.',
            style: TextStyle(color: Colors.grey[600], fontSize: 11),
          ),
          Text(
            'All right reserved.',
            style: TextStyle(color: Colors.grey[600], fontSize: 11),
          ),
        ],
      ),
    );
  }

  Future<void> _onEdit(UserModel user) async {
    final nameC = TextEditingController(text: user.fullname);
    final emailC = TextEditingController(text: user.email);
    final phoneC = TextEditingController(text: user.phonenumber);

    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Edit Profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _editField(nameC, "Nama Lengkap"),
              height(16),
              _editField(emailC, "Email"),
              height(16),
              _editField(phoneC, "Nomor Telepon"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updated = UserModel(
        id: user.id,
        fullname: nameC.text,
        email: emailC.text,
        phonenumber: phoneC.text,
      );

      await DBHelper.updateUser(updated);

      setState(() {
        widget.user.fullname = updated.fullname;
        widget.user.email = updated.email;
        widget.user.phonenumber = updated.phonenumber;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Data Berhasil Diedit'),
            ],
          ),
          backgroundColor: Color(0xFF2F6B6A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }

  Widget _editField(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// reusable helper
Widget _buildInfoItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFF40E0D0).withOpacity(0.2),
        width: 1.5,
      ),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF2F6B6A)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    ),
  );
}

// SizedBox helpers
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
