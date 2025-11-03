import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Model/imunisasi_model.dart';

class ImunisasiPage extends StatefulWidget {
  const ImunisasiPage({Key? key}) : super(key: key);

  @override
  State<ImunisasiPage> createState() => _ImunisasiPageState();
}

String _monthName(int m) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "Mei",
    "Jun",
    "Jul",
    "Agu",
    "Sep",
    "Okt",
    "Nov",
    "Des",
  ];
  return months[m - 1];
}

class _ImunisasiPageState extends State<ImunisasiPage> {
  List<Imunisasi> ImunisasiList = [
    Imunisasi(
      id: 1,
      name: 'Hepatitis B',
      ageMonth: 0,
      date: DateTime(2025, 9, 15),
      reminder: false,
    ),
    Imunisasi(
      id: 2,
      name: 'BCG',
      ageMonth: 1,
      date: DateTime(2025, 10, 15),
      reminder: false,
    ),
    Imunisasi(
      id: 3,
      name: 'DPT-HB-Hib 1',
      ageMonth: 2,
      date: DateTime(2025, 11, 15),
      reminder: true,
    ),
    Imunisasi(
      id: 4,
      name: 'Polio 1',
      ageMonth: 2,
      date: DateTime(2025, 11, 15),
      reminder: true,
    ),
    Imunisasi(
      id: 5,
      name: 'DPT-HB-Hib 2',
      ageMonth: 3,
      date: DateTime(2025, 12, 15),
      reminder: false,
    ),
    Imunisasi(
      id: 6,
      name: 'Polio 2',
      ageMonth: 3,
      date: DateTime(2025, 12, 15),
      reminder: false,
    ),
    Imunisasi(
      id: 7,
      name: 'DPT-HB-Hib 3',
      ageMonth: 4,
      date: DateTime(2026, 1, 15),
      reminder: false,
    ),
    Imunisasi(
      id: 8,
      name: 'Polio 3',
      ageMonth: 4,
      date: DateTime(2026, 1, 15),
      reminder: false,
    ),
  ];

  // int get upcomingCount =>
  //     Imunisasi.where((i) => i.status == ImunisasiStatus.upcoming).length;
  late List<Imunisasi> imunisasi;

  @override
  void initState() {
    super.initState();
    imunisasi = ImunisasiList;
    imunisasi.sort((a, b) => a.date.compareTo(b.date));
  }

  // Imunisasi? get nextImunisasi {
  //   final now = DateTime.now();
  //   return imunisasi.firstWhere(
  //     (i) => i.date.isAfter(now),
  //     orElse: () => imunisasi.last,
  //   );
  // }

  Imunisasi? get nextImunisasi {
    final now = DateTime.now();
    try {
      return imunisasi.firstWhere(
        (i) => i.date.isAfter(DateTime(now.year, now.month, now.day)),
      );
    } catch (e) {
      // jika semua lewat, kembalikan null atau yang terakhir
      return null;
    }
  }

  // void toggleReminder(int id) {
  //   setState(() {
  //     final idx = imunisasi.indexWhere((i) => i.id == id);
  //     if (idx != -1) imunisasi[idx].reminder = !imunisasi[idx].reminder;
  //   });
  // }

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
          children: [
            //Header Jadwal Imunisasi
            _buildHeader(),
            height(20),

            //Imunisasi Berikutnya
            _buildNextImunisasi(),
            height(20),

            //Daftar Jadwal Imunisasi
            _buildSectionTitle("Daftar Jadwal Imunisasi"),

            //List Jenis Imunisasi
            _buildListImunisasi(),
            height(15),

            //Info Notifikasi Penting
            _buildImportantNotification(),
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
          child: Icon(Icons.calendar_month, color: Color(0xFF2F6B6A), size: 24),
        ),
        width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jadwal Imunisasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F6B6A),
              ),
            ),
            Text(
              'Perhatikan jadwal imunisasi anak',
              // '$upcomingCount jadwal akan datang',
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

  Widget _buildNextImunisasi() {
    final next = nextImunisasi;
    if (next == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFBCEDE6),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text('Tidak ada jadwal imunisasi mendatang'),
      );
    }

    final daysLeft = next.date.difference(DateTime.now()).inDays;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6B6A), Color(0xFF40E0D0)],
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
      // Content
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
            size: 24,
          ),
          width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Imunisasi Berikutnya',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                height(15),
                //Jenis Imunisasi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffD4F2F1).withOpacity(0.5),
                    // gradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    // colors: [ Color(0xFFD4F2F1), Color(0xFF40E0D0)],
                    // ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2F6B6A).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        next.name,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF2F6B6A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "${next.date.day} ${_monthName(next.date.month)} ${next.date.year} • $daysLeft hari lagi",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 243, 243, 243),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   '(Atur Nama Jenis Imunisasi)',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                // height(5),
                // Text(
                //   '(Atur Tanggal) • 2 hari lagi',
                //   style: TextStyle(
                //     fontSize: 13,
                //     color: Colors.white.withOpacity(0.95),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2F6B6A),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildListImunisasi() {
    return Column(
      children: imunisasi.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFF40E0D0).withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _getStatusIcon(item.status),
                width(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6B6A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Usia ${item.ageMonth} bulan',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${item.date.day} ${_monthName(item.date.month)} ${item.date.year}",
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.status == ImunisasiStatus.upcoming
                                ? 'Akan Datang'
                                : item.status == ImunisasiStatus.completed
                                ? 'Selesai'
                                : 'Terlambat',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Transform.scale(
                          //   scale: 0.85,
                          //   child: Switch(
                          //     value: item.reminder,
                          //     // onChanged: () {},
                          //     onChanged: (_) => toggleReminder(item.id),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _getStatusIcon(ImunisasiStatus status) {
    switch (status) {
      case ImunisasiStatus.completed:
        return Icon(Icons.check_circle, color: Colors.green[600], size: 20);
      case ImunisasiStatus.upcoming:
        return Icon(Icons.schedule, color: Colors.blue[600], size: 20);
      case ImunisasiStatus.overdue:
      default:
        return Icon(Icons.error, color: Colors.red[600], size: 20);
    }
  }

  Widget _buildImportantNotification() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFEDD5).withOpacity(0.6),
            Color(0xFFFFF9F0).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Color.fromARGB(255, 219, 163, 89).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 219, 163, 89).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('⚠', style: TextStyle(fontSize: 16)),
              ),
              width(12),
              const Text(
                'Informasi Penting!',
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height(12),
          Text(
            'Imunisasi lengkap sangat penting untuk mencegah stunting dan penyakit berbahaya. Jangan lewatkan imunisasi sesuai jadwal yang telah ditentukan.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF92400E).withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
