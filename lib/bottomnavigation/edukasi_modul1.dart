// Class baru untuk next page article
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi_page.dart';

class ArticleType1 extends StatefulWidget {
  const ArticleType1({super.key});
  @override
  State<ArticleType1> createState() => _ArticleType1PageState();
}

class _ArticleType1PageState extends State<ArticleType1> {
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 300;

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
        padding: EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header (Back + Save Icon)
            _buildHeader(),
            SizedBox(height: 10),

            //Category
            _buildCategory(),

            //Judul
            _buildTitle(),
            _buildMetaInfo(),
            SizedBox(height: 12),

            //Isi Artikel
            _buildArticleContent(),
            SizedBox(height: 24),

            //Like Share
            _buildEngagement(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _circleIconButton(
          Icons.arrow_back,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Row(
          children: [
            _circleIconButton(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.teal : Colors.black,
              onTap: () {
                setState(() => isBookmarked = !isBookmarked);
              },
            ),
            const SizedBox(width: 8),
            _circleIconButton(Icons.share),
          ],
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xff2f6b6a),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "1000 HPK",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        width(6),
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xff2f6b6a),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "ASI",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      "1000 Hari Pertama Kehidupan (HPK): Kunci Cegah Stunting",
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 22),

          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Bdn. Yurenda Aurelia S.Tr.Keb.",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                "22 Februari 2024",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 118, 118, 118),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Masalah stunting masih menjadi episode panjang masalah kesehatan balita di Indonesia. Stunting adalah kondisi gagal tumbuh pada anak balita akibat kekurangan gizi kronis terutama pada 1.000 Hari Pertama Kehidupan (HPK). Anak dengan stunting biasanya ditandai dengan tinggi badan yang sangat pendek hingga melampaui defisit 2 SD (-2SD) di bawah median panjang atau tinggi badan berdasarkan usia.",
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          "Dampak dari stunting tidak hanya pada tinggi badan yang kurang namun juga perkembangan intelektual, kognitif, motorik yang buruk dan bahkan mengurangi produktivitas sehingga menyebabkan kerugian ekonomi di masa depan. Maka dari itu, pencegahan terutama pada 1000 HPK sangat diperlukan, yakni mulai dari bayi dalam kandungan hingga usia 23 bulan.",
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          "1. Periode Kehamilan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Pemeriksaan kehamilan rutin (Antenatal Care/ANC) merupakan langkah penting untuk mencegah stunting sejak masa kehamilan. Ibu hamil disarankan melakukan pemeriksaan minimal 6 kali — 1 kali pada trimester pertama, 2 kali pada trimester kedua, dan 3 kali pada trimester ketiga. Setidaknya dua pemeriksaan dilakukan oleh dokter kandungan menggunakan USG untuk memantau kesehatan ibu dan janin, termasuk berat badan dan lingkar lengan atas (LiLA) guna menilai status gizi. Jika ibu mengalami kekurangan energi kronis (KEK), perlu diberikan PMT (Pemberian Makanan Tambahan) untuk membantu kenaikan berat badan.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Selain itu, ibu hamil dianjurkan untuk:',
          style: TextStyle(height: 1.6),
        ),
        Text(
          '📌  Minum minimal 90 tablet tambah darah (TTD) selama kehamilan.',
          style: TextStyle(height: 1.6),
        ),
        Text(
          '📌  Mengonsumsi makanan bergizi seimbang, mencakup makanan pokok, protein hewani, kacang-kacangan, buah, dan sayur.',
          style: TextStyle(height: 1.6),
        ),
        Text(
          '📌  Menambah satu porsi makanan utama atau selingan setiap hari.',
          style: TextStyle(height: 1.6),
        ),
        Text(
          '📌  Memenuhi kebutuhan cairan 8-12 gelas (2-3 liter) per hari.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),

        Text(
          "2. Periode Menyusui (Bayi 0-6 Bulan)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Pencegahan stunting pasca melahirkan dapat dilakukan dengan:',
          style: TextStyle(height: 1.6),
        ),
        Text(
          '📌  Melakukan Inisiasi Menyusu Dini (IMD) dan memberikan kolostrum sebagai imun alami pertama bayi.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          '📌  Memberikan ASI eksklusif selama 6 bulan pertama tanpa tambahan makanan atau minuman lain.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          '📌  Melakukan pemantauan tumbuh kembang rutin minimal 1 kali sebulan di posyandu atau puskesmas.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Adapun untuk pencegahan penyakit, bayi dianjurkan mendapat imunisasi dasar lengkap dan ibu mendapatkan suplementasi kapsul vitamin A dalam 1-2 hari pasca persalinan untuk menjaga kesehatan dan kualitas ASI.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          "3. BADUTA (Bawah Dua Tahun) 6-23 Bulan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Intervensi gizi untuk mencegah stunting dilakukan dengan memberikan ASI hingga usia 23 bulan dan memulai MP-ASI setelah 6 bulan. Upaya tambahan meliputi pemberian obat cacing, suplementasi zinc dan vitamin A, fortifikasi zat besi pada makanan, imunisasi dasar dan lanjutan, serta perlindungan dari penyakit seperti malaria dan diare.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildEngagement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
              likeCount += isLiked ? 1 : -1;
            });
          },
          child: Row(
            children: [
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey[700],
              ),
              SizedBox(width: 6),
              Text(likeCount.toString()),
            ],
          ),
        ),
        Row(
          children: [
            Icon(Icons.share, color: Color.fromARGB(255, 118, 118, 118)),
            SizedBox(width: 6),
            Text(
              "Bagikan",
              style: TextStyle(color: Color.fromARGB(255, 118, 118, 118)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, {Color? color, VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: color ?? Colors.black),
      ),
    );
  }

  // class _TipBox extends StatelessWidget {
  // const _TipBox();

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 12),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.teal[50],
  //       border: Border(left: BorderSide(color: Colors.teal.shade400, width: 4)),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: const Text(
  //       "💡 Tips Ahli: Konsumsi makanan ini secara rutin dan seimbang untuk hasil maksimal. Kombinasikan dengan olahraga dan tidur cukup.",
  //       style: TextStyle(color: Colors.teal, height: 1.5),
  //     ),
  //   );
  // }
}

  // @override
  // Widget build(BuildContext context) {
  //   switch (article.uiType) {
  //     case 'type1':
  //       return _buildType1(context, article);
  //     case 'type2':
  //       return _buildType2(context, article);
  //     case 'type3':
  //       return _buildType3(context, article);
  //     case 'type4':
  //       return _buildType4(context, article);
  //     default:
  //       return _buildDefault(context, article);
  //   }
  // }

  // Widget _buildType1(BuildContext context, Article article) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 8,
  //                   vertical: 4,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: Colors.green[50],
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Text(
  //                   "Kekurangan Gizi Kronis",
  //                   style: TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //               ),
  //               Text(
  //                 '1000 HPK Kunci Cegah Stunting',
  //                 style: TextStyle(fontSize: 20, color: Color(0xff2f6b6a)),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     // Padding(
  //     //   padding: const EdgeInsets.all(20),
  //     //   child: Text(article.content, style: const TextStyle(fontSize: 14)),
  //     // ),
  //   );
  // }

  // Widget _buildType2(BuildContext context, Article article) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text(article.title), backgroundColor: Colors.pink),
  //     body: Center(
  //       child: Card(
  //         margin: const EdgeInsets.all(20),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           // child: Text(article.content, style: const TextStyle(fontSize: 16)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildType3(BuildContext context, Article article) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(article.title),
  //       backgroundColor: Colors.orange,
  //     ),
  //     body: ListView(
  //       padding: const EdgeInsets.all(20),
  //       children: [
  //         Icon(Icons.restaurant_menu, size: 80, color: Colors.orange),
  //         const SizedBox(height: 20),
  //         // Text(article.content, style: const TextStyle(fontSize: 14)),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildType4(BuildContext context, Article article) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text(article.title), backgroundColor: Colors.green),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'Tips Penting',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 10),
  //           // Text(article.content, style: const TextStyle(fontSize: 14)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildDefault(BuildContext context, Article article) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text(article.title)),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20),
  //       // child: Text(article.content),
  //     ),
  //   );
  // }

