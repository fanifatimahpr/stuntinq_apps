import 'package:flutter/material.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              _buildHeader(),
              SizedBox(height: 15),

              //Progress Edukasi
              _buildProgressEducation(),
              SizedBox(height: 15),

              //List Modul Edukasi

              //Frequently Ask Questions
              _buildFAQ(),
            ],
          ),
        ),
      ),
    );
  }
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
        child: Icon(Icons.menu_book, color: Color(0xFF2F6B6A), size: 24),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modul Edukasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2F6B6A),
            ),
          ),
          Text(
            'Pelajari tentang stunting',
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

Widget _buildProgressEducation() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2F6B6A), Color(0xFF359a99), Color(0xFF40E0D0)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF2F6B6A).withOpacity(0.3),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        // Decorative circle
        // Positioned(
        //   top: -30,
        //   right: -30,
        //   child: Container(
        //     width: 96,
        //     height: 96,
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.1),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        // ),
        // Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progres Pembelajaran',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(10),
            //         child: LinearProgressIndicator(
            //           // value: progress,
            //           backgroundColor: Colors.white.withOpacity(0.3),
            //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            //           minHeight: 8,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Text('',
            //       // '$completedModules/${modules.length}',
            //       style: TextStyle(
            //         fontSize: 13,
            //         color: Colors.white,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 8),
            Text(
              'Terus belajar untuk lindungi anak dari stunting!',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFAQ() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF40E0D0).withOpacity(0.2), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FAQ - Pertanyaan Umum',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2F6B6A),
          ),
          // ),
          // const SizedBox(height: 12),
          // ...faqs.asMap().entries.map((entry) {
          //   int index = entry.key;
          //   FAQ faq = entry.value;
          //   return Column(
          //     children: [
          //       if (index > 0) const SizedBox(height: 8),
          //       _buildFAQItem(faq),
          //     ],
          //   );
          // }
          // )
          // .toList(
        ),
      ],
    ),
  );
}
