import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Model/edukasi_model.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi_modul1.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi_modul2.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi_modul3.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi_modul4.dart';

// MODEL ARTIKEL
class Article {
  final String title;
  final String? content;
  final IconData icon;
  final String uiType;
  final bool completed;

  Article({
    required this.title,
    this.content,
    required this.icon,
    required this.uiType,
    this.completed = false,
  });
}

class EdukasiFirebase extends StatefulWidget {
  const EdukasiFirebase({super.key});

  @override
  State<EdukasiFirebase> createState() => _EdukasiFirebaseState();
}

class _EdukasiFirebaseState extends State<EdukasiFirebase> {
  // DAFTAR ARTIKEL
  final List<Article> articles = [
    Article(
      title: '1000 Hari Pertama Kehidupan',
      // content: '',
      icon: Icons.child_care, // ikon khusus
      uiType: 'type1', // nanti di next page pakai layout type1
    ),
    Article(
      title: 'Nutrisi Ibu Hamil',
      // content: 'Isi artikel 2...',
      icon: Icons.local_hospital,
      uiType: 'type2', // layout berbeda
    ),
    Article(
      title: 'MPASI Bergizi',
      // content: 'Isi artikel 3...',
      icon: Icons.restaurant_menu,
      uiType: 'type3',
    ),
    Article(
      title: 'Peran Imunisasi',
      // content: 'Isi artikel 4...',
      icon: Icons.vaccines,
      uiType: 'type4',
    ),
  ];

  List<FAQ> faqs = [
    FAQ(
      question: 'Apa perbedaan stunting dan gizi buruk?',
      answer:
          'Stunting adalah kondisi gagal tumbuh pada anak karena kekurangan gizi kronis, yang ditandai dengan tinggi badan di bawah standar. Gizi buruk lebih umum dan dapat mempengaruhi berat badan dan kondisi kesehatan secara keseluruhan.',
    ),
    FAQ(
      question: 'Kapan periode kritis pencegahan stunting?',
      answer:
          'Periode kritis adalah 1000 hari pertama kehidupan, mulai dari masa kehamilan hingga anak berusia 2 tahun. Nutrisi yang baik pada periode ini sangat penting untuk mencegah stunting.',
    ),
    FAQ(
      question: 'Apa saja tanda-tanda anak stunting?',
      answer:
          'Tanda utama adalah tinggi badan lebih pendek dari standar usianya. Tanda lain: pertumbuhan lambat, wajah tampak lebih muda, perkembangan kognitif terlambat, dan sistem imun lemah.',
    ),
    FAQ(
      question: 'Bagaimana cara mencegah stunting?',
      answer:
          'Cara mencegah: nutrisi seimbang saat hamil, ASI eksklusif 6 bulan, MPASI bergizi, imunisasi lengkap, sanitasi baik, dan pemantauan pertumbuhan rutin di posyandu.',
    ),
  ];

  // int get completedEducation => modul.where((m) => m.completed).length;
  // double get progress => (completedEducation / modul.length);

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
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            _buildHeader(),
            height(20),

            //Progress Edukasi
            _buildProgressEducation(),
            height(25),

            //List Modul Edukasi
            ...articles.map(
              (article) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildListModul(article),
              ),
            ),

            height(15),

            //Frequently Ask Questions
            _buildFAQ(),
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
          child: Icon(Icons.menu_book, color: Color(0xFF2F6B6A), size: 24),
        ),
        width(12),
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
              'Pelajari Tentang Stunting',
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
        gradient: const LinearGradient(
          colors: [Color(0xFF2F6B6A), Color(0xFF359a99), Color(0xFF40E0D0)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6B6A).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📝  Edukasi Pencegahan Stunting',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Baca artikel untuk meningkatkan pemahaman dan melindungi anak dari stunting.',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildListModul(Article article) {
    return InkWell(
      onTap: () {
        switch (article.uiType) {
          case 'type1':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticleType1()),
            );
            break;
          case 'type2':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticleType2()),
            );
            break;
          case 'type3':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticleType3()),
            );
            break;
          case 'type4':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticleType4()),
            );
            break;
          default:
            // Optional: jika ada uiType tak dikenal
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Halaman belum tersedia')),
            );
        }
      },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFF40E0D0).withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF40E0D0).withOpacity(0.2),
                    const Color(0xFF2F6B6A).withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                article.icon,
                color: const Color(0xFF2F6B6A),
                size: 18,
              ),
            ),
            width(12),
            Expanded(
              child: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F6B6A),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(22),
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
          Row(
            children: [
              Text('❓', style: TextStyle(fontSize: 16)),
              width(10),
              Text(
                'FAQ - Pertanyaan Umum',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F6B6A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...faqs.asMap().entries.map((entry) {
            int index = entry.key;
            FAQ faq = entry.value;
            return Column(
              children: [
                if (index > 0) const SizedBox(height: 8),
                _buildFAQItem(faq),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFAQItem(FAQ faq) {
    return FAQExpansionTile(question: faq.question, answer: faq.answer);
  }
}

// Class baru untuk FAQ
class FAQExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const FAQExpansionTile({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<FAQExpansionTile> createState() => _FAQExpansionTileState();
}

class _FAQExpansionTileState extends State<FAQExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            widget.question,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2F6B6A),
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Color(0xFF2F6B6A),
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
