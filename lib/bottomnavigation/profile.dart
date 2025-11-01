// import 'package:flutter/material.dart';
// import 'package:stuntinq_apps/Model/user_model.dart';

// class ProfilePage extends StatefulWidget {
//   final UserModel user;

//   ProfilePage({required this.user});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   bool _showLogoutConfirm = false;

//   final Map<String, String> _userData = {
//     'name': 'Name',
//     'email': 'xxx@email.com',
//     'phone': '+62 812 xxx',
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(children: [_buildBackground(), _buildLayer()]),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: const Color(0xffD4F2F1),
//     );
//   }

//   Widget _buildLayer() {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //Header
//             _buildHeader(),

//             //Akun (login)
//             _buildInfoUserAccount(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildHeader() {
//   return Row(
//     children: [
//       Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF40E0D0).withOpacity(0.3),
//               Color(0xFF2F6B6A).withOpacity(0.3),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(Icons.person, color: Color(0xFF2F6B6A), size: 24),
//       ),
//       width(12),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Profil',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF2F6B6A),
//             ),
//           ),
//           Text(
//             'Informasi Akun',
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

// Widget _buildInfoUserAccount() {
//   return Column(
//     children: [
//       _buildInfoItem(
//         icon: Icons.person_outline,
//         title: 'Nama Lengkap',
//         subtitle: _userData['name'] ?? '',
//         onTap: () {},
//       ),
//       height(12),
//       _buildInfoItem(
//         icon: Icons.email_outlined,
//         title: 'Email',
//         subtitle: _userData['email'] ?? '',
//         onTap: () {},
//       ),
//       height(12),
//       _buildInfoItem(
//         icon: Icons.phone_outlined,
//         title: 'Nomor Telepon',
//         subtitle: _userData['phone'] ?? '',
//         onTap: () {},
//       ),
//     ],
//   );
// }

// Widget _buildInfoItem({
//   required IconData icon,
//   required String title,
//   required String subtitle,
//   required VoidCallback onTap,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.8),
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(
//         color: const Color(0xFF40E0D0).withOpacity(0.2),
//         width: 1.5,
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.05),
//           blurRadius: 15,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           // HapticFeedback.lightImpact();
//           // onTap();
//         },
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Icon Container
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       const Color(0xFF40E0D0).withOpacity(0.2),
//                       const Color(0xFF2F6B6A).withOpacity(0.2),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, size: 20, color: const Color(0xFF2F6B6A)),
//               ),
//               const SizedBox(width: 12),

//               // Text Content
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         color: Color(0xFF2F6B6A),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subtitle,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),

//               // Arrow Icon
//               Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// // //Tampilkan data
// // Text("Nama: ${user?.fullname ?? ""}")
// // Text("Email: ${user?.email ?? ""}")

// //Sized Box
// SizedBox height(double h) => SizedBox(height: h);
// SizedBox width(double w) => SizedBox(width: w);
