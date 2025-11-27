import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:stuntinq_apps/SQFLite/Model/peta_model.dart';

class PetaFirebase extends StatefulWidget {
  const PetaFirebase({Key? key}) : super(key: key);

  @override
  State<PetaFirebase> createState() => _PetaFirebaseState();
}

class _PetaFirebaseState extends State<PetaFirebase> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';

  // === LOCATION SERVICE ===
  final Location _location = Location();
  LocationData? _currentLocation;

  // === FIREBASE ===
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _isLoading = true;

  // Fake data (sementara)
  final List<PetaModel> _allFacilities = [
    PetaModel(
      id: 1,
      name: 'Puskesmas Kelapa Dua',
      type: 'Puskesmas',
      distance: '0.8 km',
      address: 'Jl. Kelapa Dua No. 12, Jakarta Barat',
      phone: '021-5555-1234',
      hours: '08:00 - 16:00',
      rating: 4.5,
      isOpen: true,
    ),
    PetaModel(
      id: 2,
      name: 'Posyandu Melati',
      type: 'Posyandu',
      distance: '1.2 km',
      address: 'Jl. Melati Raya No. 45, Jakarta Barat',
      phone: '021-5555-5678',
      hours: '08:00 - 12:00',
      rating: 4.3,
      isOpen: true,
    ),
  ];

  List<PetaModel> get _filteredFacilities {
    List<PetaModel> filtered = _allFacilities;

    if (_selectedFilter != 'Semua') {
      filtered = filtered.where((f) => f.type == _selectedFilter).toList();
    }

    if (_searchController.text.isNotEmpty) {
      filtered = filtered
          .where(
            (f) =>
                f.name.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ) ||
                f.address.toLowerCase().contains(
                      _searchController.text.toLowerCase(),
                    ),
          )
          .toList();
    }
    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

 Future<void> _initializePage() async {
  try {
    await _getUserLocation().timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        setState(() => _isLoading = false);
      },
    );
  } catch (e) {
    setState(() => _isLoading = false);
  }

  // Jika berhasil atau error → tetap keluar loading
  setState(() => _isLoading = false);
  _location.onLocationChanged.listen((loc) {
  setState(() => _currentLocation = loc);
});

}

  // -------------------------------
  // 🔥 GET USER LOCATION (Firebase logic cleaned)
  // -------------------------------
  Future<void> _getUserLocation() async {
  bool serviceEnabled = await _location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await _location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  PermissionStatus permission = await _location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await _location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return;
    }
  }

  // Ambil lokasi sekali saja → biarkan future selesai
  _currentLocation = await _location.getLocation();
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // CALL PHONE → SNACKBAR
  void _callFacility(PetaModel facility) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.phone, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text('Memanggil ${facility.phone}')),
          ],
        ),
        backgroundColor: const Color(0xFF2F6B6A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF2F6B6A)))
            : Stack(children: [_buildBackground(), _buildLayer()]),
      ),
    );
  }

  // ================================
  //            UI SECTION
  // ================================

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
            _buildHeader(),
            height(20),
            _buildSearchBar(),
            height(16),
            _buildMapLocation(),
            height(20),
            _buildFacilityHeader(),
            height(8),
            _buildFacilityList(),
            height(16),
            _buildTips(),
          ],
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Row(
      children: [
        _headerIcon(),
        width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Peta Fasilitas Kesehatan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F6B6A),
              ),
            ),
            Text(
              'Informasi Fasilitas Kesehatan Terdekat',
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

  Widget _headerIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF40E0D0).withOpacity(0.3),
            const Color(0xFF2F6B6A).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.location_pin, color: Color(0xFF2F6B6A), size: 24),
    );
  }

  // SEARCH BAR
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Cari fasilitas kesehatan...',
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // MAP SHOW (DUMMY)
  Widget _buildMapLocation() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF40E0D0).withOpacity(0.2),
            const Color(0xFF2F6B6A).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.map_outlined, size: 40, color: Color(0xFF2F6B6A)),
            SizedBox(height: 12),
            Text(
              'Peta Interaktif',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2F6B6A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // LIST HEADER
  Widget _buildFacilityHeader() {
    return const Text(
      'Daftar Fasilitas',
      style: TextStyle(
        color: Color(0xFF2F6B6A),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // LIST FASKES
  Widget _buildFacilityList() {
    if (_filteredFacilities.isEmpty) {
      return SizedBox(
        height: 80,
        child: Center(
          child: Text(
            'Tidak ada fasilitas ditemukan',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      );
    }

    return Column(
      children: _filteredFacilities
          .map((facility) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _facilityCard(facility),
              ))
          .toList(),
    );
  }

  Widget _facilityCard(PetaModel facility) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              facility.name,
              style: const TextStyle(
                color: Color(0xFF2F6B6A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            height(8),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                width(8),
                Text(facility.phone, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            height(12),
            _buildActionButton(
              icon: Icons.phone,
              label: 'Hubungi',
              onTap: () => _callFacility(facility),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 16, color: const Color(0xFF2F6B6A)),
        label: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2F6B6A),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF2F6B6A), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E8),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Text(
        'Kunjungi posyandu secara rutin setiap bulan untuk pemantauan tumbuh kembang.',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Color(0xFF92400E),
          height: 1.5,
        ),
      ),
    );
  }
}

// Sized Boxes
SizedBox height(double h) => SizedBox(height: h);
SizedBox width(double w) => SizedBox(width: w);
