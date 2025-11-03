import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Model/edukasi_model.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
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
            height(15),

            //List Modul Edukasi
            ...modul.map(
              (modul) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildListModul(modul),
              ),
            ),

            // _buildListModul(modul),
            height(20),

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
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2F6B6A).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
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
              height(12),
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
              //     Text(
              //       '',
              //       // '$completedEducation/${modul.length}',
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

  Widget _buildListModul(Education modul) {
    return InkWell(
      onTap: () {
        print('Tapped on module: ${modul.title}');
      },
      //Jika mau ontap ke next page
      //       onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ModulDetailPage(modul: modul),
      //     ),
      //   );
      // },
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Color(0xFF40E0D0).withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type Icon
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: modul.type == EducationType.video
                      ? [Color(0xFFFEE2E2), Color(0xFFFCE7F3)]
                      : [
                          Color(0xFF40E0D0).withOpacity(0.2),
                          Color(0xFF2F6B6A).withOpacity(0.2),
                        ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                modul.type == EducationType.video
                    ? Icons.play_arrow
                    : Icons.menu_book,
                color: modul.type == EducationType.video
                    ? Color(0xFFDC2626)
                    : Color(0xFF2F6B6A),
                size: 16,
              ),
            ),
            width(12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              modul.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2F6B6A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              modul.duration,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        modul.completed
                            ? Icons.check_circle
                            : Icons.chevron_right,
                        color: modul.completed
                            ? Colors.green[600]
                            : Colors.grey[400],
                        size: 20,
                      ),
                    ],
                  ),
                  if (modul.completed) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
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
