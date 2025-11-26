// Class baru untuk next page article
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/SQFLite/main%20page/edukasi_page.dart';

class ArticleType4 extends StatefulWidget {
  const ArticleType4({super.key});
  @override
  State<ArticleType4> createState() => _ArticleType4PageState();
}

class _ArticleType4PageState extends State<ArticleType4> {
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 468;

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
            "Imunisasi Dasar",
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
            "PD3I",
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
      "Pentingnya Imunisasi: Meningkatkan Kekebalan Sebagai Pondasi Pencegah Penyakit",
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
                "01 Januari 2024",
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
          'Imunisasi adalah suatu upaya untuk menimbulkan/meningkatkan kekebalan seseorang secara aktif terhadap suatu penyakit sehingga bila suatu saat terpajan dengan penyakit tersebut tidak akan sakit atau hanya mengalami sakit ringan. Penyakit tersebut dikenal sebagai Penyakit-penyakit yang Dapat Dicegah Dengan Imunisasi (PD3I).',style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          "Apa Itu PD3I?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 3),
        Text(
          'Penyakit yang Dapat Dicegah dengan Imunisasi atau PD3I merupakan penyakit yang disebabkan oleh virus dan bakteri. Untuk penyakit yang disebabkan oleh virus yaitu Cacar, Campak, Polio, Hepatitis B, Hepatitis A, Influenza, Haemophilus. Sementara, penyakit yang disebabkan oleh bakteri, misalnya Pertusis, Difteri, Tetanus, Tuberkulosis.', style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text(
          'Terdapat beberapa PD3I antara lain hepatitis B, tuberkulosis, polio, difteri, pertusis (batuk rejan), tetanus, campak, rubela, pneumonia (radang paru), meningitis, kanker leher rahim yang disebabkan oleh infeksi Human Papilloma Virus (HPV), ensefalitis (radang otak) akibat infeksi virus Japanese Encephalitis (JE), dan diare yang disebabkan oleh infeksi Rotavirus.',style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),

        Text("A. Proteksi Individu", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          'Setiap orang yang mendapatkan imunisasi akan membentuk  antibodi spesifik terhadap penyakit tertentu. ',
          style: TextStyle(height: 1.6),
        ),
        SizedBox(height: 10),
        Text('B. Membentuk Kekebalan Kelompok (Herd Immunity)', style: TextStyle(fontWeight: FontWeight.bold)),
        
        Text(
          'Apabila cakupan imunisasi tinggi dan merata dapat membentuk kekebalan kelompok dan melindungi  kelompok masyarakat yang rentan.',
          style: TextStyle(height: 1.6),
        ),

         SizedBox(height: 10),
        Text('C. Proteksi Lintas Kelompok', style: TextStyle(fontWeight: FontWeight.bold)),
        
        Text(
          'Pemberian imunisasi pada kelompok usia tertentu (anak) dapat membatasi penularan kepada ',
          style: TextStyle(height: 1.6),),
        
         SizedBox(height: 12),
        Text(
          "Penyakit yang Dapat Dicegah dengan PD3I",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xff2f6b6a),
          ),
        ),
        SizedBox(height: 5),
        Text('1. Penyakit Polio', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 3),
        Text('2. Penyakit Campak Rubela', style: TextStyle(fontWeight: FontWeight.w500)),
         SizedBox(height: 3),
        Text('3. Penyakit Tetanus Neonatarum', style: TextStyle(fontWeight: FontWeight.w500)),
        
         SizedBox(height: 3),
         Text('4. Penyakit Pertusis (Batuk 100 Hari)', style: TextStyle(fontWeight: FontWeight.w500)),
         SizedBox(height: 3),
         Text('5. Penyakit Difteri', style: TextStyle(fontWeight: FontWeight.w500)),
         SizedBox(height: 3),
         Text('6. Penyakit Hepatitis B', style: TextStyle(fontWeight: FontWeight.w500)),
         SizedBox(height: 3),
        Text('7. Penyakit Kanker Serviks', style: TextStyle(fontWeight: FontWeight.w500)),
         SizedBox(height: 12),
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
//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);