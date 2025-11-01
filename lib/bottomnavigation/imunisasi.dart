import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Model/imunisasi_model.dart';

class ImunisasiPage extends StatefulWidget {
  const ImunisasiPage({super.key});

  @override
  State<ImunisasiPage> createState() => _ImunisasiPageState();
}

class _ImunisasiPageState extends State<ImunisasiPage> {
  // List<ImunisasiPage> ImunisasiPages = [
  //   Imunisasi(
  //     id: 1,
  //     name: 'Hepatitis B',
  //     ageMonth: 0,
  //     date: '15 Jan 2025',
  //     status: ImunisasiPageStatus.completed,
  //     reminder: false,
  //   ),
  //   Imunisasi(
  //     id: 2,
  //     name: 'BCG',
  //     ageMonth: 1,
  //     date: '15 Feb 2025',
  //     status: ImunisasiPageStatus.completed,
  //     reminder: false,
  //   ),
  //   Imunisasi(
  //     id: 3,
  //     name: 'DPT-HB-Hib 1',
  //     ageMonth: 2,
  //     date: '15 Mar 2025',
  //     status: ImunisasiPageStatus.upcoming,
  //     reminder: true,
  //   ),
  //   Imunisasi(
  //     id: 4,
  //     name: 'Polio 1',
  //     ageMonth: 2,
  //     date: '15 Mar 2025',
  //     status: ImunisasiPageStatus.upcoming,
  //     reminder: true,
  //   ),
  //   Imunisasi(
  //     id: 5,
  //     name: 'DPT-HB-Hib 2',
  //     ageMonth: 3,
  //     date: '15 Apr 2025',
  //     status: ImunisasiPageStatus.upcoming,
  //     reminder: false,
  //   ),
  //   Imunisasi(
  //     id: 6,
  //     name: 'Polio 2',
  //     ageMonth: 3,
  //     date: '15 Apr 2025',
  //     status: ImunisasiPageStatus.upcoming,
  //     reminder: false,
  //   ),
  //   Imunisasi(
  //     id: 7,
  //     name: 'DPT-HB-Hib 3',
  //     ageMonth: 4,
  //     date: '15 Mei 2025',
  //     status: ImunisasiPageStatus.upcoming,
  //     reminder: false,
  //   ),
  //   Imunisasi(
  //     id: 8,
  //     name: 'Polio 3',
  //     ageMonth: 4,
  //     date: '15 Mei 2025',
  //     status: ImmunizationStatus.upcoming,
  //     reminder: false,
  //   ),
  // ];
  // void toggleReminder(int id) {
  //   setState(() {
  //     final index = Imunisasi.indexWhere((imm) => imm.id == id);
  //     if (index != -1) {
  //       Imunisasi[index].reminder = !Imunisasi[index].reminder;
  //     }
  //   });
  // }

  // int get upcomingCount =>
  //     Imunisasi.where((i) => i.status == ImunisasiStatus.upcoming).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              //Header Jadwal Imunisasi
              _buildHeader(),
              SizedBox(height: 15),

              //Imunisasi Berikutnya
              _buildNextImunisasi(),
              SizedBox(height: 15),

              //Daftar Jadwal Imunisasi
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Daftar Jadwal Imunisasi',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 12),

              //List Jenis Imunisasi
              _buildListImunisasi(),
              SizedBox(height: 15),

              //Info Notifikasi Penting
              _buildImportantNotification(),
            ],
          ),
        ),
      ),
    );
  }
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
      const SizedBox(width: 12),
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
            '(Atur Jadwal Upcoming)',
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
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2F6B6A), Color(0xFF359a99), Color(0xFF40E0D0)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF2F6B6A).withOpacity(0.3),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    // Content
    child: Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.notifications_active, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Imunisasi Berikutnya',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(Atur Nama Jenis Imunisasi)',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(Atur Tanggal) • 2 hari lagi',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildListImunisasi() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(1.0),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Color(0xFF40E0D0).withOpacity(0.2), width: 1),
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
        // Status Icon
        Padding(
          padding: const EdgeInsets.only(top: 2),
          // child: _getStatusIcon(immunization.status),
        ),
        const SizedBox(width: 12),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '(Atur Nama Jenis Imunisasi)',
                          // imunisasi.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2F6B6A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '(Atur Usia (xxx) Bulan)',
                          // 'Usia ${immunization.ageMonth} bulan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _getStatusBadge(immunization.status),
                ],
              ),
              const SizedBox(height: 8),

              // Date
              Text(
                '(Atur Tanggal Imunisasi)',
                // imunisasi.date,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildImportantNotification() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFF9F0), Color(0xFFFFEDD5)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFD88D).withOpacity(0.5), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning),
            Text(
              'Penting!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF78350F),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Imunisasi lengkap sangat penting untuk mencegah stunting dan penyakit berbahaya. Jangan lewatkan imunisasi sesuai jadwal yang telah ditentukan.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF92400E),
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
