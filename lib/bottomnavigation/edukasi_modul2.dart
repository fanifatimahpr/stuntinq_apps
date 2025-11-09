// Class baru untuk next page article
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/bottomnavigation/edukasi.dart';

class ArticleType2 extends StatefulWidget {
  const ArticleType2({super.key});
  @override
  State<ArticleType2> createState() => _ArticleType2PageState();
}

class _ArticleType2PageState extends State<ArticleType2> {
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
            "Kehamilan",
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
            "Nutrisi",
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
      "Nutrisi Ibu Hamil Terpenuhi: Kehamilan Lancar",
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
                "01 April 2024",
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
          'Kehamilan merupakan pengalaman yang penuh kebahagiaan sekaligus tantangan, karena ibu perlu menjaga kesehatan dirinya dan janin secara bersamaan. Selama kebutuhan nutrisinya terpenuhi, tidak ada yang perlu dikhawatirkan. Meski nafsu makan meningkat dan muncul keinginan khusus terhadap makanan tertentu, ibu hamil tetap perlu mengatur pola makan dengan bijak agar asupan gizi seimbang dan tidak berlebihan.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Selain zat gizi makro seperti karbohidrat, protein dan lemak, ibu hamil juga membutuhkan zat gizi mikro, seperti vitamin dan suplemen. Berikut adalah zat gizi penting yang harus ada dalam makanan Ibu hamil untuk memastikan kesehatan ibu dan janin dalam kandungannya.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 12),
        Text("1. Asam Folat", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Asam folat berperan penting dalam pembentukan sel dan organ janin serta membantu menjaga tekanan darah ibu hamil. Kekurangannya dapat memicu gangguan pertumbuhan janin dan komplikasi seperti preeklamsia. Ibu hamil disarankan mengonsumsi 600–800 mcg asam folat per hari yang dapat diperoleh dari kacang-kacangan, hati, telur, dan sayuran hijau.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),

        Text("2. Kalsium", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Kalsium dibutuhkan dalam pembentukan tulang dan gigi janin, serta menjaga kesehatan tulang ibu hamil. Kalsium juga membantu menurunkan risiko gangguan kehamilan, seperti hipertensi dan kelahiran prematur. Asupan kalsium bisa didapat dari sumber protein hewani seperti susu, produk susu (yoghurt, keju), ikan, tahu dan sayuran berwarna hijau tua. ',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text('3. Protein', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
          'Ikan dan ayam, terutama yang tidak berlemak, dan telur merupakan sumber protein hewani yang dibutuhkan sebagai sumber kalori dan pembentukan darah bagi ibu hamil, serta zat pembangun jaringan tubuh pada janin. Pastikan ikan dan telur sampai benar-benar masak, dan tidak dimakan mentah-mentah.',
          style: TextStyle(height: 1.6),
        ),

        SizedBox(height: 10),
        Text("4. Lemak", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Lemak sehat, seperti asam lemak omega 3 dan DHA (asam dokosaheksaenoat), mendukung perkembangan mata dan otak janin yang sehat. Lemak yang sehat bisa didapat dari alpukat, kacang-kacangan, biji-bijian dan ikan kaya lemak, seperti salmon, sarden, dan ikan tuna.',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text("5. Zat Besi", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Zat besi dibutuhkan untuk pembentukan sel darah merah, karena meningkatnya volume darah yang dibutuhkan selama kehamilan. Kekurangan zat besi dapat meningkatkan risiko bayi lahir prematur, berat badan lahir rendah, serta depresi pasca melahirkan. Asupan zat besi bisa didapatkan dari daging merah tanpa lemak, ikan, unggas, sayuran dan kacang-kacangan, serta suplemen tablet tambah darah (TTD).',
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
