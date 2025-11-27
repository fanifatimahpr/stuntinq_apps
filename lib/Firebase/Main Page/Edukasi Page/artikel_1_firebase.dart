import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Firebase/service/firebase_service.dart';

class ArticleType1Firebase extends StatefulWidget {
  final String articleId;
  const ArticleType1Firebase({super.key, required this.articleId});

  @override
  State<ArticleType1Firebase> createState() => _ArticleType1FirebasePageState();
}

class _ArticleType1FirebasePageState extends State<ArticleType1Firebase> {
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialStatus();
  }

  void _loadInitialStatus() async {
    // Ambil status like & bookmark
    final like = await FirebaseService.isLiked(widget.articleId);
    final bookmark = await FirebaseService.isBookmarked(widget.articleId);

    // Stream untuk jumlah like real-time
    FirebaseService.likeCount(widget.articleId).listen((count) {
      setState(() => likeCount = count);
    });

    setState(() {
      isLiked = like;
      isBookmarked = bookmark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [_buildBackground(), _buildLayer()],
        ),
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
            _buildHeader(),
            SizedBox(height: 10),
            _buildCategory(),
            _buildTitle(),
            _buildMetaInfo(),
            SizedBox(height: 12),
            _buildArticleContent(),
            SizedBox(height: 24),
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
              onTap: () async {
                final newState = !isBookmarked;
                setState(() => isBookmarked = newState);
                await FirebaseService.toggleBookmark(widget.articleId);
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
              color: Colors.white,
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
              color: Colors.white,
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
          onTap: () async {
            setState(() => isLiked = !isLiked);
            await FirebaseService.toggleLike(widget.articleId);
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
}

// Sized Box helpers
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
