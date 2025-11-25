import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Model/imunisasi_model.dart';
import 'package:table_calendar/table_calendar.dart';

class ImunisasiFirebase extends StatefulWidget {
  const ImunisasiFirebase({Key? key}) : super(key: key);

  @override
  State<ImunisasiFirebase> createState() => _ImunisasiFirebaseState();
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

class _ImunisasiFirebaseState extends State<ImunisasiFirebase> {
  List<Imunisasi> ImunisasiList = [
    Imunisasi(
      id: 1,
      name: 'Hepatitis B',
      ageMonth: 0,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 2,
      name: 'BCG',
      ageMonth: 1,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 3,
      name: 'DPT-HB-Hib 1',
      ageMonth: 2,
      date: DateTime.now(),
      reminder: true,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 4,
      name: 'Polio 1',
      ageMonth: 2,
      date: DateTime.now(),
      reminder: true,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 5,
      name: 'DPT-HB-Hib 2',
      ageMonth: 3,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 6,
      name: 'Polio 2',
      ageMonth: 3,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 7,
      name: 'DPT-HB-Hib 3',
      ageMonth: 4,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
    Imunisasi(
      id: 8,
      name: 'Polio 3',
      ageMonth: 4,
      date: DateTime.now(),
      reminder: false,
      completed: false,
      status: ImunisasiStatus.upcoming,
    ),
  ];
  DateTime? tanggalLahirAnak;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // int get upcomingCount =>
  //     Imunisasi.where((i) => i.status == ImunisasiStatus.upcoming).length;
  late List<Imunisasi> imunisasi;

  @override
  void initState() {
    super.initState();
    imunisasi = ImunisasiList;
    imunisasi.sort((a, b) => a.date.compareTo(b.date));
  }

  void _updateImunisasiDates() {
    if (tanggalLahirAnak == null) return;

    final now = DateTime.now();

    setState(() {
      for (var imun in imunisasi) {
        // Hitung tanggal imunisasi = tanggal lahir + ageMonth bulan
        final newDate = DateTime(
          tanggalLahirAnak!.year,
          tanggalLahirAnak!.month + imun.ageMonth,
          tanggalLahirAnak!.day,
        );

        imun.date = newDate;

        // Tentukan status
        if (newDate.isBefore(DateTime(now.year, now.month, now.day))) {
          imun.status = ImunisasiStatus.overdue; // sudah lewat
        } else if (newDate.year == now.year &&
            newDate.month == now.month &&
            newDate.day == now.day) {
          imun.status = ImunisasiStatus.upcoming; // hari ini
        } else {
          imun.status = ImunisasiStatus.upcoming; // akan datang
        }
      }

      imunisasi.sort((a, b) => a.date.compareTo(b.date));
    });
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
            height(25),

            //Pilih Tanggal Lahir
            _buildSectionTitle("Pilih Tanggal Lahir Anak"),
            height(8),

            //Calendar
            _buildBirthCalendar(),
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
              'Perhatikan Jadwal Imunisasi Anak',
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
    final completedList = imunisasi.where((i) => i.completed).toList();
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6B6A), Color(0xFF359a99), Color(0xFF40E0D0)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2F6B6A).withOpacity(0.15),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      // Content
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🔔', style: TextStyle(fontSize: 20)),
          width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Imunisasi Berikutnya',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.4)),
                height(4),

                //Jenis Imunisasi
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      next.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // height(5),
                    Text(
                      "${next.date.day} ${_monthName(next.date.month)} ${next.date.year} • $daysLeft hari lagi",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height(8),
                    if (completedList.isNotEmpty) ...[
                      // Text(
                      //   "✅ Sudah dilakukan:",
                      //   style: TextStyle(
                      //     color: Colors.white.withOpacity(0.9),
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      for (var done in completedList)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "✓ ${done.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),

                            // width(30),
                            Text(
                              'Selesai',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF40E0D0).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Text(
          //   "Pilih Tanggal Lahir Anak",
          //   style: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w700,
          //     color: Color(0xFF2F6B6A),
          //   ),
          // ),
          // const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.now(),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                tanggalLahirAnak = selectedDay;
                _updateImunisasiDates();
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 48, 184, 170),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color(0xFF2F6B6A),
                shape: BoxShape.circle,
              ),
              weekendTextStyle: const TextStyle(color: Colors.redAccent),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 10),
          if (tanggalLahirAnak != null)
            Text(
              "Tanggal lahir anak Anda: ${tanggalLahirAnak!.day} ${_monthName(tanggalLahirAnak!.month)} ${tanggalLahirAnak!.year}",
              style: TextStyle(
                fontSize: 13,
                color: const Color(0xFF2F6B6A),
                fontWeight: FontWeight.w600,
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
            padding: const EdgeInsets.all(16),
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
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F6B6A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Usia ${item.ageMonth} bulan',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 85, 85, 85),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Jadwal Imunisasi: ${item.date.day} ${_monthName(item.date.month)} ${item.date.year}",
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          //Menambahkan fitur checklist
                          Checkbox(
                            value: item.completed,
                            activeColor: Color(0xFF2F6B6A),
                            onChanged: (value) {
                              setState(() {
                                item.completed = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),

                      Text(
                        item.status == ImunisasiStatus.upcoming
                            ? 'Akan Datang'
                            : item.status == ImunisasiStatus.completed
                            ? 'Selesai'
                            : 'Sudah Lewat',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
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
