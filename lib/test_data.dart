import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

/// Model untuk Sumber Gizi
class NutritionSource {
  final String id;
  final String name;
  final String portion;
  final DateTime dateAdded;

  NutritionSource({
    required this.id,
    required this.name,
    required this.portion,
    required this.dateAdded,
  });
}

/// Model untuk Keluhan
class HealthComplaint {
  final String id;
  final String complaint;
  final String severity; // Ringan, Sedang, Berat
  final DateTime dateAdded;

  HealthComplaint({
    required this.id,
    required this.complaint,
    required this.severity,
    required this.dateAdded,
  });
}

/// Halaman Input Data Antropometri & Profil Anak
/// Menampilkan profil anak dan form untuk input data pertumbuhan
class AnthropometricInputPage extends StatefulWidget {
  const AnthropometricInputPage({Key? key}) : super(key: key);

  @override
  State<AnthropometricInputPage> createState() => _AnthropometricInputPageState();
}

class _AnthropometricInputPageState extends State<AnthropometricInputPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers untuk form inputs
  final TextEditingController _nameController = TextEditingController(text: 'Aira Azzahra');
  final TextEditingController _ageController = TextEditingController(text: '6');
  final TextEditingController _weightController = TextEditingController(text: '8.3');
  final TextEditingController _heightController = TextEditingController(text: '67');
  final TextEditingController _headCircumferenceController = TextEditingController(text: '43.5');
  
  String _selectedGender = 'female';
  bool _showSuccess = false;
  late AnimationController _successAnimationController;

  // Lists untuk nutrition dan complaints
  List<NutritionSource> _nutritionSources = [
    NutritionSource(
      id: '1',
      name: 'Nasi Putih',
      portion: '1 mangkok',
      dateAdded: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NutritionSource(
      id: '2',
      name: 'Telur Rebus',
      portion: '1 butir',
      dateAdded: DateTime.now(),
    ),
  ];

  List<HealthComplaint> _healthComplaints = [
    HealthComplaint(
      id: '1',
      complaint: 'Nafsu makan berkurang',
      severity: 'Ringan',
      dateAdded: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _successAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
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
      HapticFeedback.mediumImpact();
      setState(() {
        _showSuccess = true;
      });
      _successAnimationController.forward();
      
      // Hide success message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showSuccess = false;
          });
          _successAnimationController.reverse();
        }
      });

      // TODO: Save data to backend/database
      print('Data saved: ${_nameController.text}');
    }
  }

  String _getGrowthStatus() {
    // TODO: Implement actual growth status calculation based on WHO standards
    return 'Pertumbuhan Normal';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2F6B6A),
              Color(0xFF40E0D0),
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Scrollable Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Profile Card
                        _buildProfileCard(),
                        const SizedBox(height: 16),
                        
                        // Success Message
                        if (_showSuccess) _buildSuccessMessage(),
                        if (_showSuccess) const SizedBox(height: 16),
                        
                        // Input Form
                        _buildInputForm(),
                        const SizedBox(height: 16),
                        
                        // Nutrition Sources Section
                        _buildNutritionSection(),
                        const SizedBox(height: 16),
                        
                        // Health Complaints Section
                        _buildComplaintsSection(),
                        const SizedBox(height: 16),
                        
                        // Save Button
                        _buildSaveButton(),
                        const SizedBox(height: 16),
                        
                        // Tips Card
                        _buildTipsCard(),
                        const SizedBox(height: 100), // Space for bottom navigation
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.child_care_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Profil Anak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2F6B6A),
            Color(0xFF40E0D0),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
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
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Avatar & Info
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
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
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
                    const SizedBox(width: 16),
                    
                    // Name & Info
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
                          const SizedBox(height: 4),
                          Text(
                            '${_ageController.text.isEmpty ? '0' : _ageController.text} bulan • ${_selectedGender == 'male' ? '👦 Laki-laki' : '👧 Perempuan'}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildStatChip(
                                Icons.monitor_weight_outlined,
                                '${_weightController.text} kg',
                              ),
                              const SizedBox(width: 8),
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
                const SizedBox(height: 16),
                Divider(color: Colors.white.withOpacity(0.2)),
                const SizedBox(height: 12),
                
                // Status
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      _getGrowthStatus(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '✓',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
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

  Widget _buildSuccessMessage() {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _successAnimationController,
          curve: Curves.elasticOut,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF10B981),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Data berhasil disimpan!',
                style: TextStyle(
                  color: Color(0xFF065F46),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
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
            const SizedBox(height: 16),
            
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
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGenderSelector(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Weight Input
            _buildInputField(
              controller: _weightController,
              label: 'Berat Badan (kg)',
              icon: Icons.monitor_weight_outlined,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Berat badan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Height Input
            _buildInputField(
              controller: _heightController,
              label: 'Tinggi Badan (cm)',
              icon: Icons.straighten,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tinggi badan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Head Circumference Input
            _buildInputField(
              controller: _headCircumferenceController,
              label: 'Lingkar Kepala (cm)',
              icon: Icons.child_care_outlined,
              hint: '0.0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF40E0D0),
            ),
            const SizedBox(width: 8),
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
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: (value) => setState(() {}),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 15,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFF40E0D0).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFF40E0D0).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2F6B6A),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
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
        const Text(
          'Jenis Kelamin',
          style: TextStyle(
            color: Color(0xFF2F6B6A),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'male',
                  child: Text('👦 Laki-laki'),
                ),
                DropdownMenuItem(
                  value: 'female',
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

  // NUTRITION SECTION
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
                color: const Color(0xFF40E0D0),
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
                    Icon(
                      Icons.restaurant,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Belum ada sumber gizi tercatat',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap ikon + untuk menambah',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
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
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final nutrition = _nutritionSources[index];
                return _buildNutritionItem(nutrition);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(NutritionSource nutrition) {
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
            child: const Icon(
              Icons.dining,
              size: 20,
              color: Color(0xFF2F6B6A),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nutrition.name,
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
                      nutrition.portion,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${_formatDate(nutrition.dateAdded)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _deleteNutrition(nutrition.id),
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  // COMPLAINTS SECTION
  Widget _buildComplaintsSection() {
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
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.health_and_safety_outlined,
                      size: 20,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Keluhan Tumbuh Kembang',
                    style: TextStyle(
                      color: Color(0xFF2F6B6A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _showAddComplaintDialog,
                icon: const Icon(Icons.add_circle),
                color: Colors.orange,
                iconSize: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (_healthComplaints.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Belum ada keluhan tercatat',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap ikon + untuk menambah',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _healthComplaints.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final complaint = _healthComplaints[index];
                return _buildComplaintItem(complaint);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildComplaintItem(HealthComplaint complaint) {
    Color severityColor;
    switch (complaint.severity) {
      case 'Ringan':
        severityColor = Colors.green;
        break;
      case 'Sedang':
        severityColor = Colors.orange;
        break;
      case 'Berat':
        severityColor = Colors.red;
        break;
      default:
        severityColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: severityColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: severityColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              size: 20,
              color: severityColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complaint.complaint,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F6B6A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: severityColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        complaint.severity,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: severityColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${_formatDate(complaint.dateAdded)}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _deleteComplaint(complaint.id),
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  // DIALOG FUNCTIONS
  void _showAddNutritionDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController portionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF40E0D0).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: Color(0xFF2F6B6A),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Tambah Sumber Gizi',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nama Makanan',
                hintText: 'Contoh: Nasi Putih',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2F6B6A),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: portionController,
              decoration: InputDecoration(
                labelText: 'Porsi',
                hintText: 'Contoh: 1 mangkok',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2F6B6A),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && 
                  portionController.text.isNotEmpty) {
                _addNutrition(
                  nameController.text,
                  portionController.text,
                );
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6B6A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showAddComplaintDialog() {
    final TextEditingController complaintController = TextEditingController();
    String selectedSeverity = 'Ringan';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.health_and_safety_outlined,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Tambah Keluhan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: complaintController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Keluhan',
                    hintText: 'Deskripsikan keluhan...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF2F6B6A),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tingkat Keparahan',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F6B6A),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Ringan', 'Sedang', 'Berat'].map((severity) {
                    final isSelected = selectedSeverity == severity;
                    Color color;
                    switch (severity) {
                      case 'Ringan':
                        color = Colors.green;
                        break;
                      case 'Sedang':
                        color = Colors.orange;
                        break;
                      case 'Berat':
                        color = Colors.red;
                        break;
                      default:
                        color = Colors.grey;
                    }

                    return ChoiceChip(
                      label: Text(severity),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setStateDialog(() {
                            selectedSeverity = severity;
                          });
                        }
                      },
                      selectedColor: color.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: isSelected ? color : Colors.grey[700],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (complaintController.text.isNotEmpty) {
                    _addComplaint(
                      complaintController.text,
                      selectedSeverity,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F6B6A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Tambah'),
              ),
            ],
          );
        },
      ),
    );
  }

  // CRUD FUNCTIONS
  void _addNutrition(String name, String portion) {
    setState(() {
      _nutritionSources.add(
        NutritionSource(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          portion: portion,
          dateAdded: DateTime.now(),
        ),
      );
    });
    
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('$name berhasil ditambahkan'),
          ],
        ),
        backgroundColor: const Color(0xFF2F6B6A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _deleteNutrition(String id) {
    final nutrition = _nutritionSources.firstWhere((n) => n.id == id);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Hapus Sumber Gizi?'),
        content: Text('Apakah Anda yakin ingin menghapus "${nutrition.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _nutritionSources.removeWhere((n) => n.id == id);
              });
              Navigator.pop(context);
              
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.delete, color: Colors.white),
                      const SizedBox(width: 12),
                      Text('${nutrition.name} dihapus'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _addComplaint(String complaint, String severity) {
    setState(() {
      _healthComplaints.add(
        HealthComplaint(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          complaint: complaint,
          severity: severity,
          dateAdded: DateTime.now(),
        ),
      );
    });
    
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            const Expanded(child: Text('Keluhan berhasil ditambahkan')),
          ],
        ),
        backgroundColor: const Color(0xFF2F6B6A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _deleteComplaint(String id) {
    final complaint = _healthComplaints.firstWhere((c) => c.id == id);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Hapus Keluhan?'),
        content: Text('Apakah Anda yakin ingin menghapus keluhan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _healthComplaints.removeWhere((c) => c.id == id);
              });
              Navigator.pop(context);
              
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Keluhan dihapus'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
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
        borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Simpan Semua Data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF40E0D0).withOpacity(0.1),
            const Color(0xFF2F6B6A).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.3),
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
                  color: const Color(0xFF40E0D0).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: Color(0xFF2F6B6A),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tips Kesehatan',
                style: TextStyle(
                  color: Color(0xFF2F6B6A),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem('Catat sumber gizi anak secara rutin'),
          const SizedBox(height: 8),
          _buildTipItem('Segera konsultasi jika ada keluhan serius'),
          const SizedBox(height: 8),
          _buildTipItem('Ukur tinggi & berat badan setiap bulan'),
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
            color: const Color(0xFF2F6B6A).withOpacity(0.6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF2F6B6A).withOpacity(0.8),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
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
}
