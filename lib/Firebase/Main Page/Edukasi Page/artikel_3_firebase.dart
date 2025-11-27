import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Firebase/service/firebase_service.dart';

class ArticleType3Firebase extends StatefulWidget {
  final String articleId;
  const ArticleType3Firebase({super.key, required this.articleId});

  @override
  State<ArticleType3Firebase> createState() => _ArticleType3FirebaseState();
}

class _ArticleType3FirebaseState extends State<ArticleType3Firebase> {
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 287;

  @override
  void initState() {
    super.initState();
    _loadInitialStatus();
  }

  void _loadInitialStatus() async {
    final like = await FirebaseService.isLiked(widget.articleId);
    final bookmark = await FirebaseService.isBookmarked(widget.articleId);

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
          onTap: () => Navigator.pop(context),
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
        _categoryChip("Prinsip MPASI"),
        width(6),
        _categoryChip("Menu MPASI"),
      ],
    );
  }

  Widget _categoryChip(String label) => Container(
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xff2f6b6a),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _buildTitle() {
    return const Text(
      "Resep MPASI Lengkap: Jawaban Pertumbuhan Optimal Anak",
      style: TextStyle(
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
        children: const [
          CircleAvatar(radius: 22),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        Text("🍚  Karbohidrat, terdiri dari makanan pokok seperti nasi, kentang, gandum, jagung atau ubi.", style: TextStyle(height: 1.6)),
        Text(
          '🐔  Protein hewani, terdiri dari daging sapi, daging ayam/unggas, ikan, dan telur.',
          style: TextStyle(height: 1.6),
        ),
        Text(
          "🥜  Protein nabati, terdiri dari kacang-kacangan dan olahannya, seperti tahu dan tempe.",
          style: TextStyle(height: 1.6),
        ),
        Text(
          "🥑  Lemak sehat, seperti alpukat dan minyak zaitun.",
          style: TextStyle(height: 1.6),
        ),
         Text(
          "🥕  Vitamin A, bisa diperoleh dari wortel, apel dan pisang atau ubi jalar.",
          style: TextStyle(height: 1.6),
        ),
        Text(
          "🍊  Vitamin C, bisa diperoleh dari buah dan sayuran, seperti jeruk, papaya dan brokoli.",
          style: TextStyle(height: 1.6),
        ),
        Text(
          "🐮  Zat besi, diperoleh dari hati (ayam dan sapi) dan sayur bayam.",
          style: TextStyle(height: 1.6),
        ),
        Text(
          "🍌  Asam folat, bisa diperoleh dari buah pisang dan sayuran berdaun hijau gelap.",
          style: TextStyle(height: 1.6),
        ),

        SizedBox(height: 20),

        Text(
          "Menu MPASI Bayi Usia 6-8 Bulan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
         Text(
          "Usia 6 bulan merupakan masa peralihan dari ASI eksklusif ke MPASI dimana bayi sudah mulai bisa mencerna makanan yang lebih padat. Inilah saat yang tepat memberi si kecil makanan bertekstur lunak, seperti bubur, kentang tumbuk, pisang atau alpukat.",
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
       
        Text(
          "Usia 6 bulan merupakan masa peralihan dari ASI eksklusif ke MPASI dimana bayi sudah mulai bisa mencerna makanan yang lebih padat. Inilah saat yang tepat memberi si kecil makanan bertekstur lunak, seperti bubur, kentang tumbuk, pisang atau alpukat.",
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Makanan yang bisa disiapkan Ibu antara lain bubur pisang campur apel dan pir, bubur sup daging kacang merah, atau puding kentang ayam dan telur. Unduh resep mpasi lokal untuk bayi usia 6-8 bukan di sini.', style: TextStyle(height: 1.6),
          ),
          SizedBox(height: 20),

        Text(
          "Menu MPASI Bayi Usia 9-11 Bulan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
         Text(
          'Di usia 9 bulan bayi mulai beralih ke menu makanan yang bervariasi dan bertekstur kasar. Walaupun ASI tetap merupakan sumber gizi utama, MPASI mulai berkontribusi terhadap pemenuhan kebutuhan nutrisi si kecil.', style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Berikan makanan yang lembut seperti nasi tim atau yang dicincang halus, dicacah, dan diiris-iris. Beberapa resep MPASI yang bisa ibu siapkan antara lain sop daging cincang, nasi tim ikan tuna telur puyuh atau tim bubur manado daging dan udang.', style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 20),
        Text(
          "Menu MPASI Bayi Usia 12-23 Bulan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
         Text(
          'Saat mencapai usia 12 bulan atau 1 tahun, kebutuhan energi dan protein si kecil meningkat. Pastikan Ibu memberi si kecil protein hewani yang mengandung asam amino esensial untuk mendukung pertumbuhan otak dan sel-sel tubuh lainnya. ', style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Menu makanan yang diberikan, selain ASI, harus tetap lengkap, bervariasi dan bergizi seimbang. Pada rentang usia ini si kecil sudah mulai bisa makan nasi dan daging yang diiris-iris. Beberapa resep MPASI yang bisa ibu siapkan antara lain nasi sup telur puyuh bola ayam, nasi soto ayam kuah kuning, nasi ikan kuah kuning, dan nugget tempe ayam sayuran.', style: TextStyle(height: 1.6),
        ),
         SizedBox(height: 20),
        Text(
          "Menu MPASI Bayi Usia 2-5 Tahun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
         Text(
          'Memasuki usia 2 tahun ke atas, kemampuan fisik, intelektual dan sosial anak berkembang pesat. Anak juga sudah mulai memilih-milih makanan dan bisa makan makanan orang dewasa.', style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Berikan menu makanan yang lebih bervariasi agar anak tidak bosan. Namun tetap perhatikan kadar garam dan gula, serta hindari makanan olahan yang mengandung zat adiktif dan bahan pengawet.', style: TextStyle(height: 1.6),
        ),
        Text(
          'Beberapa resep MPASI untuk anak usia 2 tahun ke atas, antara lain nasi masak ayam kecap sayur, nasi ikan lele katsu ceria, nasi sup tabas udang sayur dan bola-bola nasi isi rabuk ikan.', style: TextStyle(height: 1.6),
        ),
         SizedBox(height: 20),
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
          children: const [
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
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Icon(icon, size: 20, color: color ?? Colors.black),
      ),
    );
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
