import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stuntinq_apps/Database/dbhelper_datapage.dart';
import 'package:stuntinq_apps/Model/data_model.dart';
import 'package:stuntinq_apps/Model/edukasi_model.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nutritionNameController =
      TextEditingController();
  final TextEditingController _nutritionPortionController =
      TextEditingController();
  List<NutritionSource> _nutritionSources = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _headCircumferenceController =
      TextEditingController();

  String _selectedGender = 'Perempuan';
  bool _showSuccess = false;
  late AnimationController _successAnimationController;

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
    headCircumferenceBoys;
    headCircumferenceGirls;
    _successAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _loadNutritionData() async {
    final data = await NutritionDB.instance.getAll();
    print("total: ${data.length}");
    setState(() {
      _nutritionSources = data;
    });
  }

  //CREATE (ADD) NUTRITION
  Future<void> _showAddNutritionDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController portionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Tambah Sumber Gizi",
            style: TextStyle(
              color: Color(0xFF2F6B6A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Makanan",
                  prefixIcon: Icon(Icons.fastfood),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: portionController,
                decoration: const InputDecoration(
                  labelText: "Porsi",
                  prefixIcon: Icon(Icons.scale),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.save_outlined, size: 18),
              label: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6B6A),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final name = nameController.text.trim();
                final portion = portionController.text.trim();

                if (name.isEmpty || portion.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Nama dan porsi tidak boleh kosong"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                // ✅ Buat data baru
                final newData = NutritionSource(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  portion: portion,
                  dateAdded: DateTime.now(),
                );

                // ✅ Simpan ke database
                await NutritionDB.instance.insert(newData);

                // ✅ Refresh UI dari DB agar langsung tampil
                await _loadNutritionData();

                // ✅ Tutup dialog setelah selesai
                if (context.mounted) Navigator.pop(context);

                // ✅ Snackbar konfirmasi
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Sumber gizi berhasil ditambahkan"),
                    backgroundColor: Colors.teal,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  //UPDATE (EDIT) NUTRITION DATA
  Future<void> _showEditNutritionDialog(NutritionSource nutrition) async {
    final nameController = TextEditingController(text: nutrition.name);
    final portionController = TextEditingController(text: nutrition.portion);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Edit Sumber Gizi",
            style: TextStyle(
              color: Color(0xFF2F6B6A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Makanan',
                  prefixIcon: Icon(Icons.fastfood),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: portionController,
                decoration: const InputDecoration(
                  labelText: 'Porsi',
                  prefixIcon: Icon(Icons.scale),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.save_outlined, size: 18),
              label: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6B6A),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final updated = NutritionSource(
                  id: nutrition.id,
                  name: nameController.text.trim(),
                  portion: portionController.text.trim(),
                  dateAdded: nutrition.dateAdded,
                );

                await NutritionDB.instance.update(updated);
                await _loadNutritionData();
                if (context.mounted) Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Data berhasil diperbarui"),
                    backgroundColor: Colors.teal,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateNutrition(NutritionSource updatedItem) async {
    await NutritionDB.instance.update(updatedItem);
    print("${updatedItem.name} berhasil diupdate");
    await _loadNutritionData(); // ✅ Refresh data setelah update
  }

  //DELETE NUTRITION DATA
  Future<void> _deleteNutrition(String id) async {
    await NutritionDB.instance.delete(id);
    _loadNutritionData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _headCircumferenceController.dispose();
    _successAnimationController.dispose();

    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccess = true;
      });
      _successAnimationController.forward();
    }
  }

  void _showDuplicateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Sumber Gizi Sudah Ada',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F6B6A),
            ),
          ),
          content: const Text(
            'Nama sumber gizi ini sudah ditambahkan sebelumnya.',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF2F6B6A)),
              ),
            ),
          ],
        );
      },
    );
  }

  //Calculate IMT
  double _calculateIMT() {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty) {
      return 0;
    }

    double weight = double.tryParse(_weightController.text) ?? 0;
    double heightCm = double.tryParse(_heightController.text) ?? 0;
    if (weight == 0 || heightCm == 0) return 0;

    double heightMeter = heightCm / 100;
    return weight / (heightMeter * heightMeter);
  }

  String _getStatus() {
    double imt = _calculateIMT();
    if (imt == 0) return 'Data belum lengkap';
    if (imt < 18.5) return 'Berat Badan Kurang (Underweight)';
    if (imt >= 18.5 && imt <= 22.9) return 'Berat Badan Normal (Ideal)';
    if (imt >= 23 && imt <= 24.9) return 'Kelebihan Berat Badan (Overweight)';
    if (imt >= 25 && imt <= 29.9) return 'Obesitas Tingkat I (Risk of Obesity)';
    if (imt >= 30) return 'Obesitas Tingkat II';
    return 'Normal';
  }

  String _getGrowthStatus() {
    double imt = _calculateIMT();
    if (imt == 0) return 'Data belum lengkap';
    if (imt < 18.5)
      return 'Berat badan anak di bawah normal. '
          'Konsultasikan dengan tenaga kesehatan dan pastikan asupan gizi cukup.';
    if (imt >= 18.5 && imt <= 22.9)
      return 'Pertumbuhan anak Anda sesuai dengan standar WHO. '
          'Lanjutkan pola asuh dan nutrisi yang baik.';
    if (imt >= 23 && imt <= 24.9)
      return 'Berat badan anak sedikit melebihi standar. '
          'Perhatikan pola makan, kurangi makanan tinggi gula dan lemak, serta dorong aktivitas fisik rutin.';
    if (imt >= 25 && imt <= 29.9)
      return 'Berat badan anak jauh di atas standar WHO. '
          'Segera konsultasikan dengan dokter anak untuk penanganan lebih lanjut dan evaluasi pola hidup sehat.';
    if (imt >= 30)
      return 'Berat badan anak jauh di atas standar WHO. '
          'Segera konsultasikan dengan dokter anak untuk penanganan lebih lanjut dan evaluasi pola hidup sehat.';
    return 'Normal';
  }

  //Calculate Lingkar Kepala
  String _getHeadCircumferenceStatus() {
    final String gender = _selectedGender;
    final int age = int.tryParse(_ageController.text) ?? 0;
    final double inputHead =
        double.tryParse(_headCircumferenceController.text) ?? 0.0;

    // Ambil referensi sesuai jenis kelamin
    final reference = headCircumference[gender];

    if (reference == null)
      return 'Data referensi jenis kelamin tidak ditemukan';
    if (reference.isEmpty) return 'Data referensi kosong';

    // Cari usia terdekat di tabel
    int closestAge = reference.keys.reduce(
      (a, b) => (age - a).abs() < (age - b).abs() ? a : b,
    );

    double median = reference[closestAge]!;

    // Toleransi WHO normal ±2 cm
    double lowerLimit = median - 2.0;
    double upperLimit = median + 2.0;

    // Tentukan status
    if (inputHead < lowerLimit) {
      return 'Lingkar kepala kecil (di bawah normal)';
    } else if (inputHead > upperLimit) {
      return 'Lingkar kepala besar (di atas normal)';
    } else {
      return 'Lingkar kepala normal';
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'NA';

    List<String> parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
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
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            _buildHeader(),
            height(20),

            //Profil Anak
            _buildChildProfile(),
            height(16),

            //IMT
            _buildIMTResult(),
            height(16),

            //Lingkar Kepala
            _buildHeadCircumfenceResult(),
            height(16),

            //Form Input Data Anak
            _buildSectionTitle('Input Data Antropometri Anak'),
            height(8),
            _buildInputForm(),
            height(16),

            //Save Button
            _buildSaveButton(),
            height(40),

            //Form Sumber Nutrisi
            _buildSectionTitle('Input Sumber Gizi Harian Anak'),
            height(8),

            _buildNutritionSection(),
            height(16),

            //Tips
            _buildTips(),
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
          child: Icon(Icons.person, color: Color(0xFF2F6B6A), size: 24),
        ),
        width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profil Anak',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F6B6A),
              ),
            ),
            Text(
              'Informasi Tumbuh Kembang Anak',
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

  Widget _buildChildProfile() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6B6A), Color(0xFF40E0D0)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6B6A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar with badge
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            child: Text(
                              _getInitials(_nameController.text),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    width(16),

                    // Nama & Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nameController.text.isEmpty
                                ? 'Nama Anak'
                                : _nameController.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          height(4),
                          Text(
                            '${_ageController.text.isEmpty ? '0' : _ageController.text} bulan • ${_selectedGender == 'Laki-Laki' ? '👦 Laki-laki' : '👧 Perempuan'}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          height(8),
                          Row(
                            children: [
                              _buildStatChip(
                                Icons.monitor_weight_outlined,
                                '${_weightController.text} kg',
                              ),
                              width(8),
                              _buildStatChip(
                                Icons.straighten,
                                '${_heightController.text} cm',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Divider
                height(16),
                Divider(color: Colors.white.withOpacity(0.2)),

                // Status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    height(4),
                    Text(
                      _getGrowthStatus(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.2,
                      ),
                    ),
                    width(4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIMTResult() {
    double imt = _calculateIMT();
    String headStatus = _getHeadCircumferenceStatus();
    return Container(
      padding: const EdgeInsets.all(18),
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
              Text('📈', style: TextStyle(fontSize: 18)),
              // ),
              width(12),
              const Text(
                'Indeks Massa Tubuh (IMT)',
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height(12),
          Row(
            children: [
              Icon(Icons.circle, size: 6, color: Color(0xFF92400E)),
              width(8),
              Expanded(
                child: Text(
                  imt == 0
                      ? 'Masukkan berat dan tinggi badan untuk menghitung IMT dan mengetahui status IMT anak Anda.'
                      : 'Hasil IMT: ${imt.toStringAsFixed(2)} (${_getStatus()})',
                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          height(6),
        ],
      ),
    );
  }

  Widget _buildHeadCircumfenceResult() {
    double imt = _calculateIMT();
    String headStatus = _getHeadCircumferenceStatus();
    return Container(
      padding: const EdgeInsets.all(18),
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
              Text('👶🏻', style: TextStyle(fontSize: 18)),
              // ),
              width(12),
              const Text(
                'Status Lingkar Kepala',
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height(12),
          Row(
            children: [
              Icon(Icons.circle, size: 6, color: Color(0xFF92400E)),
              width(8),
              Expanded(
                child: Text(
                  headStatus == 0
                      ? 'Masukkan ukuran lingkar kepala untuk mengetahui status lingkar kepala anak Anda.'
                      : 'Hasil: ${_getHeadCircumferenceStatus()}',
                  style: TextStyle(
                    color: Color(0xFF92400E),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          width(4),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11,
              fontWeight: FontWeight.w500,
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

  Widget _buildInputForm() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Input
            _buildInputField(
              controller: _nameController,
              label: 'Nama Anak',
              icon: Icons.person_outline,
              hint: 'Masukkan nama anak',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama anak tidak boleh kosong';
                }
                return null;
              },
            ),
            height(16),

            // Age & Gender Row
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    controller: _ageController,
                    label: 'Usia (bulan)',
                    icon: Icons.calendar_today_outlined,
                    hint: '0',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib diisi';
                      }
                      return null;
                    },
                  ),
                ),
                width(12),
                Expanded(child: _buildGenderSelector()),
              ],
            ),
            height(16),

            // Weight Input
            _buildInputField(
              controller: _weightController,
              label: 'Berat Badan (kg)',
              icon: Icons.monitor_weight_outlined,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Berat badan tidak boleh kosong';
                }
                return null;
              },
            ),
            height(16),

            // Height Input
            _buildInputField(
              controller: _heightController,
              label: 'Tinggi Badan (cm)',
              icon: Icons.straighten,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tinggi badan tidak boleh kosong';
                }
                return null;
              },
            ),
            height(16),

            // Head Circumference Input
            _buildInputField(
              controller: _headCircumferenceController,
              label: 'Lingkar Kepala (cm)',
              icon: Icons.child_care_outlined,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lingkar kepala tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Color(0xFF40E0D0)),
            width(8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF2F6B6A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        height(8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: const Color(0xFF40E0D0).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(
                color: const Color(0xFF40E0D0).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Color(0xFF2F6B6A), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.male, size: 22, color: Color(0xFF40E0D0)),
            Text(
              'Jenis Kelamin',
              style: TextStyle(
                color: Color(0xFF2F6B6A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        height(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFF40E0D0).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGender,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF2F6B6A),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Laki-Laki',
                  child: Text('👦 Laki-Laki'),
                ),
                DropdownMenuItem(
                  value: 'Perempuan',
                  child: Text('👧 Perempuan'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedGender = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2F6B6A), Color(0xFF40E0D0)],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6B6A).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleSubmit,
          borderRadius: BorderRadius.circular(26),
          child: const Center(
            child: Text(
              'Simpan Data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF40E0D0).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 20,
                      color: Color(0xFF2F6B6A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Sumber Gizi Anak',
                    style: TextStyle(
                      color: Color(0xFF2F6B6A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _showAddNutritionDialog,
                icon: const Icon(Icons.add_circle),
                color: const Color(0xFF2F6B6A),
                iconSize: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_nutritionSources.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.restaurant, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      'Belum ada sumber gizi tercatat',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap ikon + untuk menambah',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _nutritionSources.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = _nutritionSources[index];
                return _buildNutritionItem(item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(NutritionSource item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF40E0D0).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF40E0D0).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.dining, size: 20, color: Color(0xFF2F6B6A)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F6B6A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      item.portion,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${_formatDate(item.dateAdded)}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showEditNutritionDialog(item),
            icon: const Icon(Icons.edit_outlined),
            color: const Color(0xFF40E0D0),
            iconSize: 20,
          ),
          IconButton(
            onPressed: () => _showDeleteNutritionDialog(item),
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
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
                child: Text('💡', style: TextStyle(fontSize: 16)),
              ),
              width(12),
              const Text(
                'Tips',
                style: TextStyle(
                  color: Color(0xFF92400E),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height(12),
          _buildTipItem('Ukur tinggi badan tanpa alas kaki'),
          height(4),
          _buildTipItem('Timbang berat badan di pagi hari'),
          height(4),
          _buildTipItem('Catat hasil secara rutin setiap bulan'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Color(0xFF92400E).withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
        width(12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF92400E).withOpacity(0.8),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDeleteNutritionDialog(NutritionSource nutrition) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text("Hapus Sumber Gizi"),
            ],
          ),
          content: Text(
            "Apakah kamu yakin ingin menghapus '${nutrition.name}' dari daftar sumber gizi?",
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text("Hapus"),
              onPressed: () async {
                await _deleteNutrition(nutrition.id);
                if (context.mounted) Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
