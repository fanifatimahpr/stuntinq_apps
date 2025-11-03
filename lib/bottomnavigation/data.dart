import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(text: 'Aira Azzahra');
  final TextEditingController _ageController = TextEditingController(text: '6');
  final TextEditingController _weightController = TextEditingController(text: '8.3');
  final TextEditingController _heightController = TextEditingController(text: '67');
  final TextEditingController _headCircumferenceController = TextEditingController(text: '43.5');
  
  String _selectedGender = 'female';
  bool _showSuccess = false;
  late AnimationController _successAnimationController;
  
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
    // super.dispose();
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
      // child: Container(
      //             decoration: const BoxDecoration(
      //               color: Color(0xFFF8FAFB),
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(30),
      //                 topRight: Radius.circular(30),
      //               ),
      //             ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            _buildHeader(),
            height(20),

            //Profil Anak
            _buildProfilAnak(),
            height(16),

            //Form Input Data Anak
             _buildInputForm(),
              height(16),
             
            //Save Button
            _buildSaveButton(),
             height(26),

            //Tips
            _buildTips()

            ]
            )
            )
            );
        
  }
 Widget _buildHeader (){
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
Widget _buildProfilAnak (){
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
                            '${_ageController.text.isEmpty ? '0' : _ageController.text} bulan • ${_selectedGender == 'male' ? '👦 Laki-laki' : '👧 Perempuan'}',
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
                height(16),
                
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
                    width(4) ,        
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
 String _getInitials(String name) {
    if (name.isEmpty) return 'NA';
    
    List<String> parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
  Widget _buildInputForm (){     
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
            ),height(16),
            
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
                Expanded(
                  child: _buildGenderSelector(),
                ),
              ],
            ),
            height(16),
            
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
            height(16),
            
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
           height(16),
            
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
              size: 18,
              color: Color(0xFF40E0D0),
            ),
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
      children: [Row(
        children: [
          Icon(Icons.male,
          size: 22,
          color: Color(0xFF40E0D0),),
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
                fontSize: 14,
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
        borderRadius: BorderRadius.circular(20),
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.lightbulb_outline,
                  size: 20,
                  color: Color(0xFF92400E),
                ),
              ),
              width(12),
              const Text(
                'Tips!',
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

  }
  
//Sized Box
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);