// # Flutter Dart - Halaman Modul Edukasi StuntinQ

// Berikut adalah kode Flutter Dart untuk halaman Modul Edukasi yang sesuai dengan desain React yang telah dibuat.

// ## File: education_module_page.dart

// ```dart
// import 'package:flutter/material.dart';

// class EducationModulePage extends StatefulWidget {
//   const EducationModulePage({Key? key}) : super(key: key);

//   @override
//   State<EducationModulePage> createState() => _EducationModulePageState();
// }

// class _EducationModulePageState extends State<EducationModulePage> {
//   List<Module> modules = [
//     Module(
//       id: 1,
//       title: 'Apa Itu Stunting?',
//       duration: '5 menit',
//       completed: true,
//       type: ModuleType.video,
//     ),
//     Module(
//       id: 2,
//       title: 'Penyebab Stunting',
//       duration: '7 menit',
//       completed: true,
//       type: ModuleType.article,
//     ),
//     Module(
//       id: 3,
//       title: 'Nutrisi untuk Mencegah Stunting',
//       duration: '10 menit',
//       completed: false,
//       type: ModuleType.video,
//     ),
//     Module(
//       id: 4,
//       title: '1000 Hari Pertama Kehidupan',
//       duration: '8 menit',
//       completed: false,
//       type: ModuleType.article,
//     ),
//     Module(
//       id: 5,
//       title: 'Resep MPASI Bergizi',
//       duration: '12 menit',
//       completed: false,
//       type: ModuleType.video,
//     ),
//   ];

//   List<FAQ> faqs = [
//     FAQ(
//       question: 'Apa perbedaan stunting dan gizi buruk?',
//       answer:
//           'Stunting adalah kondisi gagal tumbuh pada anak karena kekurangan gizi kronis, yang ditandai dengan tinggi badan di bawah standar. Gizi buruk lebih umum dan dapat mempengaruhi berat badan dan kondisi kesehatan secara keseluruhan.',
//     ),
//     FAQ(
//       question: 'Kapan periode kritis pencegahan stunting?',
//       answer:
//           'Periode kritis adalah 1000 hari pertama kehidupan, mulai dari masa kehamilan hingga anak berusia 2 tahun. Nutrisi yang baik pada periode ini sangat penting untuk mencegah stunting.',
//     ),
//     FAQ(
//       question: 'Apa saja tanda-tanda anak stunting?',
//       answer:
//           'Tanda utama adalah tinggi badan lebih pendek dari standar usianya. Tanda lain: pertumbuhan lambat, wajah tampak lebih muda, perkembangan kognitif terlambat, dan sistem imun lemah.',
//     ),
//     FAQ(
//       question: 'Bagaimana cara mencegah stunting?',
//       answer:
//           'Cara mencegah: nutrisi seimbang saat hamil, ASI eksklusif 6 bulan, MPASI bergizi, imunisasi lengkap, sanitasi baik, dan pemantauan pertumbuhan rutin di posyandu.',
//     ),
//   ];

//   int get completedModules => modules.where((m) => m.completed).length;
//   double get progress => (completedModules / modules.length);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
          // padding: const EdgeInsets.all(16.0),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
//               // Header
//               _buildHeader(),
//               const SizedBox(height: 16),

//               // Progress Card
//               _buildProgressCard(),
//               const SizedBox(height: 20),

//               // Module List Title
//               Text(
//                 'Daftar Modul',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF2F6B6A),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Module List
//               ...modules.map((module) => Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: _buildModuleCard(module),
//                   )),

//               const SizedBox(height: 8),

//               // FAQ Section
//               _buildFAQCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

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
  //         child: Icon(
  //           Icons.menu_book,
  //           color: Color(0xFF2F6B6A),
  //           size: 24,
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Modul Edukasi',
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w700,
  //               color: Color(0xFF2F6B6A),
  //             ),
  //           ),
  //           Text(
  //             'Pelajari tentang stunting',
  //             style: TextStyle(
  //               fontSize: 13,
  //               color: Colors.grey[600],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildProgressCard() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(20),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //         colors: [
  //           Color(0xFF2F6B6A),
  //           Color(0xFF359a99),
  //           Color(0xFF40E0D0),
  //         ],
  //       ),
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Color(0xFF2F6B6A).withOpacity(0.3),
  //           blurRadius: 12,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       children: [
  //         // Decorative circle
  //         Positioned(
  //           top: -30,
  //           right: -30,
  //           child: Container(
  //             width: 96,
  //             height: 96,
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.1),
  //               shape: BoxShape.circle,
  //             ),
  //           ),
  //         ),
  //         // Content
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Progres Pembelajaran',
  //               style: TextStyle(
  //                 fontSize: 13,
  //                 color: Colors.white.withOpacity(0.9),
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const SizedBox(height: 12),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(10),
  //                     child: LinearProgressIndicator(
  //                       value: progress,
  //                       backgroundColor: Colors.white.withOpacity(0.3),
  //                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //                       minHeight: 8,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 12),
  //                 Text(
  //                   '$completedModules/${modules.length}',
  //                   style: TextStyle(
  //                     fontSize: 13,
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               'Terus belajar untuk lindungi anak dari stunting!',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.white.withOpacity(0.95),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

//   Widget _buildModuleCard(Module module) {
//     return InkWell(
//       onTap: () {
//         // Handle module tap - navigasi ke detail modul
//         print('Tapped on module: ${module.title}');
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.8),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Color(0xFF40E0D0).withOpacity(0.2),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Type Icon
//             Container(
//               margin: const EdgeInsets.only(top: 2),
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: module.type == ModuleType.video
//                       ? [
//                           Color(0xFFFEE2E2),
//                           Color(0xFFFCE7F3),
//                         ]
//                       : [
//                           Color(0xFF40E0D0).withOpacity(0.2),
//                           Color(0xFF2F6B6A).withOpacity(0.2),
//                         ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 module.type == ModuleType.video
//                     ? Icons.play_arrow
//                     : Icons.menu_book,
//                 color: module.type == ModuleType.video
//                     ? Color(0xFFDC2626)
//                     : Color(0xFF2F6B6A),
//                 size: 16,
//               ),
//             ),
//             const SizedBox(width: 12),

//             // Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               module.title,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF2F6B6A),
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               module.duration,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Icon(
//                         module.completed
//                             ? Icons.check_circle
//                             : Icons.chevron_right,
//                         color: module.completed
//                             ? Colors.green[600]
//                             : Colors.grey[400],
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                   if (module.completed) ...[
//                     const SizedBox(height: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFDCFCE7),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         'Selesai',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF166534),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  // Widget _buildFAQCard() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.8),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: Color(0xFF40E0D0).withOpacity(0.2),
  //         width: 1,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 12,
  //           offset: Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'FAQ - Pertanyaan Umum',
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.w600,
  //             color: Color(0xFF2F6B6A),
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         ...faqs.asMap().entries.map((entry) {
  //           int index = entry.key;
  //           FAQ faq = entry.value;
  //           return Column(
  //             children: [
  //               if (index > 0) const SizedBox(height: 8),
  //               _buildFAQItem(faq),
  //             ],
  //           );
  //         }).toList(),
  //       ],
  //     ),
  //   );
  // }

//   Widget _buildFAQItem(FAQ faq) {
//     return FAQExpansionTile(
//       question: faq.question,
//       answer: faq.answer,
//     );
//   }
// }

// // Custom Expansion Tile for FAQ
// class FAQExpansionTile extends StatefulWidget {
//   final String question;
//   final String answer;

//   const FAQExpansionTile({
//     Key? key,
//     required this.question,
//     required this.answer,
//   }) : super(key: key);

//   @override
//   State<FAQExpansionTile> createState() => _FAQExpansionTileState();
// }

// class _FAQExpansionTileState extends State<FAQExpansionTile> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.grey[200]!,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(
//           dividerColor: Colors.transparent,
//         ),
//         child: ExpansionTile(
//           tilePadding: EdgeInsets.zero,
//           title: Text(
//             widget.question,
//             style: TextStyle(
//               fontSize: 14,
//               color: Color(0xFF2F6B6A),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           trailing: Icon(
//             _isExpanded ? Icons.expand_less : Icons.expand_more,
//             color: Color(0xFF2F6B6A),
//           ),
//           onExpansionChanged: (expanded) {
//             setState(() {
//               _isExpanded = expanded;
//             });
//           },
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12.0),
//               child: Text(
//                 widget.answer,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[700],
//                   height: 1.5,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Model Classes
// class Module {
//   final int id;
//   final String title;
//   final String duration;
//   final bool completed;
//   final ModuleType type;

//   Module({
//     required this.id,
//     required this.title,
//     required this.duration,
//     required this.completed,
//     required this.type,
//   });
// }

// class FAQ {
//   final String question;
//   final String answer;

//   FAQ({
//     required this.question,
//     required this.answer,
//   });
// }

// // Enum
// enum ModuleType {
//   video,
//   article,
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
// import 'education_module_page.dart';

// // Di dalam Bottom Navigation atau Route
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => EducationModulePage(),
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

//   final List<Widget> _pages = [
//     AnthropometricInputPage(),     // Page 0
//     ImmunizationReminderPage(),    // Page 1
//     GrowthChartPage(),             // Page 2
//     EducationModulePage(),         // Page 3 - Halaman Edukasi
//     HealthFacilitiesMapPage(),     // Page 4
//     ProfilePage(),                 // Page 5
//   ];

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

// ✅ **Header dengan Ikon Gradasi** - Menampilkan judul dan deskripsi modul
// ✅ **Progress Card** - Menampilkan progres pembelajaran dengan progress bar
// ✅ **Daftar Modul Edukasi** - Video dan artikel dengan status selesai/belum
// ✅ **Icon Tipe Modul** - Video (merah/pink) dan Artikel (teal)
// ✅ **Status Completed Badge** - Badge hijau untuk modul yang sudah selesai
// ✅ **FAQ Accordion** - Expandable FAQ dengan 4 pertanyaan umum
// ✅ **Glassmorphism Effect** - Background transparan dengan blur
// ✅ **Interactive Cards** - Card modul dapat di-tap untuk navigasi
// ✅ **Responsive Design** - Dioptimalkan untuk ukuran Android compact

// ## Customisasi

// ### Mengubah Warna Tema

// ```dart
// // Ganti warna primary
// Color(0xFF2F6B6A) // Teal dark
// Color(0xFF40E0D0) // Turquoise light
// Color(0xFF359a99) // Teal medium (untuk gradasi)

// // Warna video
// Color(0xFFFEE2E2) // Red light
// Color(0xFFFCE7F3) // Pink light
// Color(0xFFDC2626) // Red icon
// ```

// ### Menambahkan Modul Baru

// ```dart
// modules.add(
//   Module(
//     id: 6,
//     title: 'Tips ASI Eksklusif',
//     duration: '6 menit',
//     completed: false,
//     type: ModuleType.video,
//   ),
// );
// ```

// ### Menambahkan FAQ Baru

// ```dart
// faqs.add(
//   FAQ(
//     question: 'Berapa lama stunting bisa dicegah?',
//     answer: 'Stunting dapat dicegah sejak dini, terutama pada 1000 hari pertama kehidupan (dari kehamilan hingga anak berusia 2 tahun).',
//   ),
// );
// ```

// ### Handle Tap Modul untuk Navigasi Detail

// ```dart
// Widget _buildModuleCard(Module module) {
//   return InkWell(
//     onTap: () {
//       // Navigasi ke halaman detail modul
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ModuleDetailPage(module: module),
//         ),
//       );
//     },
//     // ... rest of the code
//   );
// }
// ```

// ### Integrasi dengan Backend

// ```dart
// // Fetch modules dari API
// Future<List<Module>> fetchModules() async {
//   final response = await http.get(Uri.parse('YOUR_API_URL/modules'));
//   if (response.statusCode == 200) {
//     return parseModules(response.body);
//   } else {
//     throw Exception('Failed to load modules');
//   }
// }

// // Update completion status
// Future<void> markModuleComplete(int id) async {
//   await http.put(
//     Uri.parse('YOUR_API_URL/modules/$id/complete'),
//     body: {'completed': 'true'},
//   );
// }
// ```

// ## Tips Pengembangan

// ### 1. Tambahkan Video Player

// Untuk modul video, tambahkan package `video_player`:

// ```yaml
// dependencies:
//   video_player: ^2.8.0
// ```

// ### 2. Tambahkan Web View untuk Artikel

// Untuk modul artikel, gunakan `webview_flutter`:

// ```yaml
// dependencies:
//   webview_flutter: ^4.4.0
// ```

// ### 3. Tracking Progress

// Simpan progress user menggunakan `shared_preferences`:

// ```yaml
// dependencies:
//   shared_preferences: ^2.2.0
// ```

// ## Notes

// - Kode sudah menggunakan tema gradasi sesuai desain (#2F6B6A dan #40E0D0)
// - Efek glassmorphism diterapkan pada card-card
// - ExpansionTile custom untuk FAQ dengan styling yang sesuai
// - Icon berbeda untuk video (play) dan artikel (book)
// - Progress bar menampilkan persentase modul yang diselesaikan
// - Card modul sudah clickable dengan InkWell effect

// ---

// **Created for: StuntinQ Mobile App**
// **Design System: Teal-Turquoise Gradient with Glassmorphism**