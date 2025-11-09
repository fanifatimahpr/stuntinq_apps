// Class baru untuk next page article
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi.dart';

class ArticleType3 extends StatefulWidget {
  const ArticleType3({super.key});
  @override
  State<ArticleType3> createState() => _ArticleType3PageState();
}

class _ArticleType3PageState extends State<ArticleType3> {
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
            "Prinsip MPASI",
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
            "Tumbuh Optimal",
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
      "Resep MPASI Lengkap: Jawaban Pertumbuhan Optimal Anak",
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
          const CircleAvatar(
            radius: 22,
            // backgroundImage:AssetImage(assetName)
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Kementerian Kesehatan",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                "06 April 2024",
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
          'Sejak lahir, bayi memperoleh nutrisi utama dari ASI. Namun, setelah berusia enam bulan, ASI tidak lagi mencukupi kebutuhan gizinya, sehingga diperlukan MPASI sebagai pelengkap. MPASI berperan penting dalam mendukung pertumbuhan dan perkembangan optimal bayi, termasuk kenaikan berat dan tinggi badan. Kekurangan asupan gizi pada tahap ini dapat meningkatkan risiko gangguan pertumbuhan atau stunting',
          style: TextStyle(height: 1.6),
        ),

        SizedBox(height: 12),
        Text(
          "Prinsip Pemberian MPASI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),

        Text("Tepat Waktu", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Selain kebutuhan nutrisi yang tidak tercukupi hanya dengan ASI, bayi berusia 6 bulan juga sudah mulai menunjukkan ketertarikannya pada makanan. Oleh karenanya, MPASI harus mulai dikenalkan ketika bayi mencapai usia 6 bulan.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),

        Text("Aman", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Semua makanan yang akan dIberikan pada anak harus disiapkan dan disimpan dengan cara yang higienis. Semua peralatan makan harus dicuci dengan sabun khusus bayi, dan makanan diberikan dengan menggunakan tangan. ',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text('Adekuat (Cukup)', style: TextStyle(fontWeight: FontWeight.bold)),

        Text(
          'Makanan yang diberikan harus memenuhi kebutuhan anak terhadap nutrisi dan energi, yaitu karbohidrat, protein hewani dan nabati, serta vitamin dan mineral. Selain itu juga, pertimbangkan usia, jumlah, frekuensi, konsistensi/ tekstur, dan variasi makanan yang diberikan.',
          style: TextStyle(height: 1.6),
        ),

        SizedBox(height: 10),
        Text(
          "Diberikan Terjadwal dan Benar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Buat lingkungan makan anak menyenangkan dan kondusif. MPASI diberikan terjadwal dengan tiga makanan utama dan dua camilan dalam porsi kecil. Stimulasi anak untuk mulai makan sendiri dan bersihkan mulut hanya ketika selesai makan.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 20),

        Text(
          "Menu MPASI Lengkap Untuk Anak",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
        Text(
          'Memasuki usia enam bulan ke atas, bayi mengalami peningkatan aktivitas dan pertumbuhan yang memerlukan asupan gizi lengkap, terutama karbohidrat sebagai sumber energi dan protein untuk pembentukan sel tubuh. Pedoman lama berupa menu MPASI 4 bintang kini tidak lagi dianjurkan oleh WHO dan IDAI. Sebagai gantinya, digunakan konsep menu MPASI lengkap yang mencakup kandungan makronutrien dan mikronutrien untuk memenuhi kebutuhan gizi bayi secara menyeluruh.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text("5. Vitamin", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Selama kehamilan, asupan vitamin menjadi krusial, khususnya vitamin B dan D. Vitamin B kompleks (B1, B2, B6, B9, dan B12) berperan dalam produksi energi dan menjaga fungsi optimal plasenta, sementara vitamin D, terutama D3, mendukung pembentukan serta kekuatan tulang janin. Sumber vitamin B dapat ditemukan pada daging ayam, pisang, kacang-kacangan, gandum utuh, dan roti, sedangkan vitamin D diperoleh melalui konsumsi susu, ikan, jeruk, serta paparan sinar matahari pagi.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 15),
        Text(
          "💡  Selain memenuhi kebutuhan nutrisi, ibu hamil harus tetap menerapkan pola hidup sehat dan segera berkonsultasi ke dokter atau bidan.",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
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
}
