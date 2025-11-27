import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/Edukasi%20Page/artikel_1_firebase.dart';
import 'package:stuntinq_apps/Firebase/Main%20Page/Edukasi%20Page/artikel_2_firebase.dart';

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  // Contoh data artikel
  final List<Map<String, dynamic>> articles = const [
    {
      'id': '1000_hpk',
      'title': '1000 Hari Pertama Kehidupan (HPK): Kunci Cegah Stunting',
      'type': 1, 
    },
    {
      'id': 'nutrisi_hamil',
      'title': 'Nutrisi Ibu Hamil Terpenuhi: Kehamilan Lancar',
      'type': 2, 
    },
     {
      'id': 'mpasi',
      'title': 'Resep MPASI Lengkap: Jawaban Pertumbuhan Optimal Anak',
      'type': 3, 
    },
     {
      'id': 'peran_imunisasi',
      'title': 'Pentingnya Imunisasi: Meningkatkan Kekebalan Sebagai Pondasi Pencegah Penyakit',
      'type': 4, 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Artikel"),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article['title']),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Panggil halaman sesuai tipe artikel
              if (article['type'] == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleType1Firebase(articleId: article['id']),
                  ),
                );
              } else if (article['type'] == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleType2Firebase(articleId: article['id']),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
