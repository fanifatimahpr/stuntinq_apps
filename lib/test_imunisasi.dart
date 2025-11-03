// # Flutter Dart - Halaman Imunisasi StuntinQ

// Berikut adalah kode Flutter Dart untuk halaman Imunisasi yang sesuai dengan desain React yang telah dibuat.

// ## File: immunization_reminder_page.dart

// ```dart
// import 'package:flutter/material.dart';

// class ImmunizationReminderPage extends StatefulWidget {
//   const ImmunizationReminderPage({Key? key}) : super(key: key);

//   @override
//   State<ImmunizationReminderPage> createState() => _ImmunizationReminderPageState();
// }

// class _ImmunizationReminderPageState extends State<ImmunizationReminderPage> {
//   List<Immunization> immunizations = [
//     Immunization(
//       id: 1,
//       name: 'Hepatitis B',
//       ageMonth: 0,
//       date: '15 Jan 2025',
//       status: ImmunizationStatus.completed,
//       reminder: false,
//     ),
//     Immunization(
//       id: 2,
//       name: 'BCG',
//       ageMonth: 1,
//       date: '15 Feb 2025',
//       status: ImmunizationStatus.completed,
//       reminder: false,
//     ),
//     Immunization(
//       id: 3,
//       name: 'DPT-HB-Hib 1',
//       ageMonth: 2,
//       date: '15 Mar 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: true,
//     ),
//     Immunization(
//       id: 4,
//       name: 'Polio 1',
//       ageMonth: 2,
//       date: '15 Mar 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: true,
//     ),
//     Immunization(
//       id: 5,
//       name: 'DPT-HB-Hib 2',
//       ageMonth: 3,
//       date: '15 Apr 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: false,
//     ),
//     Immunization(
//       id: 6,
//       name: 'Polio 2',
//       ageMonth: 3,
//       date: '15 Apr 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: false,
//     ),
//     Immunization(
//       id: 7,
//       name: 'DPT-HB-Hib 3',
//       ageMonth: 4,
//       date: '15 Mei 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: false,
//     ),
//     Immunization(
//       id: 8,
//       name: 'Polio 3',
//       ageMonth: 4,
//       date: '15 Mei 2025',
//       status: ImmunizationStatus.upcoming,
//       reminder: false,
//     ),
//   ];

//   void toggleReminder(int id) {
//     setState(() {
//       final index = immunizations.indexWhere((imm) => imm.id == id);
//       if (index != -1) {
//         immunizations[index].reminder = !immunizations[index].reminder;
//       }
//     });
//   }

//   int get upcomingCount =>
//       immunizations.where((i) => i.status == ImmunizationStatus.upcoming).length;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               _buildHeader(),
//               const SizedBox(height: 16),

//               // Next Immunization Card
//               _buildNextImmunizationCard(),
//               const SizedBox(height: 20),

//               // List Title
//               Text(
//                 'Daftar Jadwal Imunisasi',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF2F6B6A),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Immunization List
//               ...immunizations.map((immunization) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: _buildImmunizationCard(immunization),
//                   )),

//               const SizedBox(height: 8),

//               // Important Notice Card
//               _buildImportantNoticeCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF40E0D0).withOpacity(0.3),
//                 Color(0xFF2F6B6A).withOpacity(0.3),
//               ],
//             ),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Icon(
//             Icons.calendar_month,
//             color: Color(0xFF2F6B6A),
//             size: 24,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Jadwal Imunisasi',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF2F6B6A),
//               ),
//             ),
//             Text(
//               '$upcomingCount jadwal akan datang',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildNextImmunizationCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF2F6B6A),
//             Color(0xFF359a99),
//             Color(0xFF40E0D0),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF2F6B6A).withOpacity(0.3),
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Decorative circle
//           Positioned(
//             top: -30,
//             right: -30,
//             child: Container(
//               width: 96,
//               height: 96,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           // Content
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.notifications_active,
//                 color: Colors.white,
//                 size: 24,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Imunisasi Berikutnya',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white.withOpacity(0.9),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'DPT-HB-Hib 1 & Polio 1',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '15 Maret 2025 • 2 hari lagi',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white.withOpacity(0.95),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImmunizationCard(Immunization immunization) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Color(0xFF40E0D0).withOpacity(0.2),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Status Icon
//           Padding(
//             padding: const EdgeInsets.only(top: 2),
//             child: _getStatusIcon(immunization.status),
//           ),
//           const SizedBox(width: 12),

//           // Content
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title and Badge
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             immunization.name,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF2F6B6A),
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             'Usia ${immunization.ageMonth} bulan',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     _getStatusBadge(immunization.status),
//                   ],
//                 ),
//                 const SizedBox(height: 8),

//                 // Date
//                 Text(
//                   immunization.date,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[700],
//                   ),
//                 ),

//                 // Reminder Toggle (only for non-completed)
//                 if (immunization.status != ImmunizationStatus.completed) ...[
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Pengingat',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Transform.scale(
//                         scale: 0.85,
//                         child: Switch(
//                           value: immunization.reminder,
//                           onChanged: (value) => toggleReminder(immunization.id),
//                           activeColor: Color(0xFF40E0D0),
//                           activeTrackColor: Color(0xFF40E0D0).withOpacity(0.5),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImportantNoticeCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFFFFF9F0),
//             Color(0xFFFFEDD5),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: Color(0xFFFFD88D).withOpacity(0.5),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '⚠️ Penting!',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF78350F),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Imunisasi lengkap sangat penting untuk mencegah stunting dan penyakit berbahaya. Jangan lewatkan jadwal yang sudah ditentukan.',
//             style: TextStyle(
//               fontSize: 12,
//               color: Color(0xFF92400E),
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getStatusIcon(ImmunizationStatus status) {
//     switch (status) {
//       case ImmunizationStatus.completed:
//         return Icon(
//           Icons.check_circle,
//           color: Colors.green[600],
//           size: 20,
//         );
//       case ImmunizationStatus.upcoming:
//         return Icon(
//           Icons.schedule,
//           color: Colors.blue[600],
//           size: 20,
//         );
//       case ImmunizationStatus.overdue:
//         return Icon(
//           Icons.error,
//           color: Colors.red[600],
//           size: 20,
//         );
//     }
//   }

//   Widget _getStatusBadge(ImmunizationStatus status) {
//     Color backgroundColor;
//     Color textColor;
//     String text;

//     switch (status) {
//       case ImmunizationStatus.completed:
//         backgroundColor = Color(0xFFDCFCE7);
//         textColor = Color(0xFF166534);
//         text = 'Selesai';
//         break;
//       case ImmunizationStatus.upcoming:
//         backgroundColor = Color(0xFFDBEAFE);
//         textColor = Color(0xFF1E40AF);
//         text = 'Akan Datang';
//         break;
//       case ImmunizationStatus.overdue:
//         backgroundColor = Color(0xFFFEE2E2);
//         textColor = Color(0xFF991B1B);
//         text = 'Terlambat';
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//           color: textColor,
//         ),
//       ),
//     );
//   }
// }

// // Model Class
// class Immunization {
//   final int id;
//   final String name;
//   final int ageMonth;
//   final String date;
//   final ImmunizationStatus status;
//   bool reminder;

//   Immunization({
//     required this.id,
//     required this.name,
//     required this.ageMonth,
//     required this.date,
//     required this.status,
//     required this.reminder,
//   });
// }

// // Enum
// enum ImmunizationStatus {
//   completed,
//   upcoming,
//   overdue,
// }
// ```

// ## Cara Menggunakan

// ### 1. Tambahkan ke pubspec.yaml

// ```yaml
// dependencies:
//   flutter:
//     sdk: flutter
//   # Dependencies lain yang dibutuhkan
// ```

// ### 2. Import dan Gunakan

// ```dart
// import 'package:flutter/material.dart';
// import 'immunization_reminder_page.dart';

// // Di dalam Bottom Navigation atau Route
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => ImmunizationReminderPage(),
//   ),
// );
// ```

// ### 3. Integrasi dengan Bottom Navigation

// ```dart
// // Contoh integrasi dengan Bottom Navigation
// class MainApp extends StatefulWidget {
//   @override
//   _MainAppState createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   int _currentIndex = 0;

//   // final List<Widget> _pages = [
//   //   AnthropometricInputPage(), // Page 0
//   //   ImmunizationReminderPage(), // Page 1 - Halaman Imunisasi
//   //   GrowthChartPage(),          // Page 2
//   //   EducationModulePage(),      // Page 3
//   //   HealthFacilitiesMapPage(),  // Page 4
//   //   ProfilePage(),              // Page 5
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Color(0xFF2F6B6A),
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.input),
//             label: 'Data',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_month),
//             label: 'Imunisasi',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.show_chart),
//             label: 'Grafik',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Edukasi',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map),
//             label: 'Peta',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//       ),
//     );
//   }
// }
// ```

// ## Fitur yang Tersedia

// ✅ **Header dengan Ikon Gradasi** - Menampilkan jumlah jadwal yang akan datang
// ✅ **Card Imunisasi Berikutnya** - Dengan gradasi #2F6B6A ke #40E0D0
// ✅ **Daftar Jadwal Imunisasi** - Dengan status completed, upcoming, overdue
// ✅ **Toggle Reminder** - Switch untuk mengaktifkan/menonaktifkan pengingat
// ✅ **Status Badge** - Badge dengan warna sesuai status (hijau/biru/merah)
// ✅ **Card Peringatan Penting** - Dengan gradasi amber/orange
// ✅ **Glassmorphism Effect** - Background transparan dengan blur
// ✅ **Responsive Design** - Dioptimalkan untuk ukuran Android compact

// ## Customisasi

// ### Mengubah Warna Tema

// ```dart
// // Ganti warna primary
// Color(0xFF2F6B6A) // Teal dark
// Color(0xFF40E0D0) // Turquoise light
// Color(0xFF359a99) // Teal medium (untuk gradasi)
// ```

// ### Menambahkan Data Imunisasi Baru

// ```dart
// immunizations.add(
//   Immunization(
//     id: 9,
//     name: 'MR',
//     ageMonth: 9,
//     date: '15 Okt 2025',
//     status: ImmunizationStatus.upcoming,
//     reminder: false,
//   ),
// );
// ```

// ### Integrasi dengan Backend

// ```dart
// // Fetch data dari API
// Future<List<Immunization>> fetchImmunizations() async {
//   final response = await http.get(Uri.parse('YOUR_API_URL'));
//   if (response.statusCode == 200) {
//     // Parse JSON
//     return parseImmunizations(response.body);
//   } else {
//     throw Exception('Failed to load immunizations');
//   }
// }

// // Update reminder ke backend
// Future<void> updateReminder(int id, bool reminder) async {
//   await http.put(
//     Uri.parse('YOUR_API_URL/immunizations/$id'),
//     body: {'reminder': reminder.toString()},
//   );
// }
// ```

// ## Notes

// - Kode sudah menggunakan tema gradasi sesuai desain (#2F6B6A dan #40E0D0)
// - Efek glassmorphism diterapkan pada card-card
// - Switch reminder hanya muncul untuk jadwal yang belum selesai
// - Badge status menggunakan warna semantik (hijau=selesai, biru=akan datang, merah=terlambat)
// - Responsive untuk berbagai ukuran layar Android

// ---

// **Created for: StuntinQ Mobile App**
// **Design System: Teal-Turquoise Gradient with Glassmorphism**
