import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stuntinq_apps/SQFLite/Model/peta_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaFirebase extends StatefulWidget {
  const PetaFirebase({Key? key}) : super(key: key);

  @override
  State<PetaFirebase> createState() => _PetaFirebaseState();
}

class _PetaFirebaseState extends State<PetaFirebase> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';

  GoogleMapController? _mapController;
  LatLng? _currentLatLng;

  final CameraPosition _defaultPosition = const CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 12,
  );

  final Set<Marker> _markers = {};

  // Mock data - Replace with actual data from API/Database
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
    PetaModel(
      id: 3,
      name: 'RS Harapan Sehat',
      type: 'Rumah Sakit',
      distance: '2.5 km',
      address: 'Jl. Kesehatan No. 88, Jakarta Barat',
      phone: '021-5555-9012',
      hours: '24 Jam',
      rating: 4.7,
      isOpen: true,
    ),
    PetaModel(
      id: 4,
      name: 'Klinik Pratama Sejahtera',
      type: 'Klinik',
      distance: '1.8 km',
      address: 'Jl. Sejahtera No. 23, Jakarta Barat',
      phone: '021-5555-3456',
      hours: '07:00 - 21:00',
      rating: 4.4,
      isOpen: true,
    ),
  ];

  List<PetaModel> get _filteredFacilities {
    List<PetaModel> filtered = _allFacilities;
    // Filter by type
    if (_selectedFilter != 'Semua') {
      filtered = filtered.where((f) => f.type == _selectedFilter).toList();
    }
    // Filter by search query
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
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
  // Pastikan GPS aktif
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return;
  }

  // Permission
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever ||
      permission == LocationPermission.denied) {
    return;
  }

  // Ambil lokasi saat ini
  Position pos = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  _currentLatLng = LatLng(pos.latitude, pos.longitude);

  // Set marker user
  _markers.add(
    Marker(
      markerId: const MarkerId("user"),
      position: _currentLatLng!,
      infoWindow: const InfoWindow(title: "Lokasi Anda"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ),
  );

  // Tambah marker fasilitas
  _markers.addAll([
    const Marker(
      markerId: MarkerId("f1"),
      position: LatLng(-6.200200, 106.816800),
      infoWindow: InfoWindow(title: "Puskesmas Kelapa Dua"),
    ),
    const Marker(
      markerId: MarkerId("f2"),
      position: LatLng(-6.201000, 106.815800),
      infoWindow: InfoWindow(title: "Posyandu Melati"),
    ),
  ]);

  // Update UI
  setState(() {});

  // Jika peta sudah dibuat, langsung pindah kamera
  if (_mapController != null) {
    _mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLatLng!, 15),
    );
  }
}
 @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //Snackbar Memanggil No.Telp
  void _callFacility(PetaModel facility) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.phone, color: Colors.white, size: 20),
            width(12),
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

            //Search Bar
            _buildSearchBar(),
            height(16),

            //Peta Faskes
            _buildMapGoogle(),
            height(20),

            //List Faskes
            _buildFilterFaskes(),
            height(8),
            _buildListFaskes(),
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
          child: Icon(Icons.location_pin, color: Color(0xFF2F6B6A), size: 24),
        ),
        width(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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
        onChanged: (value) => setState(() {}),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Cari fasilitas kesehatan...',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
          suffixIcon: Icon(Icons.navigation, color: Colors.grey[400], size: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF40E0D0).withOpacity(0.3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: const Color(0xFF40E0D0).withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF2F6B6A), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMapGoogle() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GoogleMap(
          initialCameraPosition:
          
          _currentLatLng == null ? _defaultPosition : CameraPosition(target: _currentLatLng!, zoom: 15),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;

            // Kamera bergerak otomatis saat map dibuat
                    if (_currentLatLng != null) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(_currentLatLng!, 15),
             );
            }
          },
        ),
      ),
    );
  }
  Widget _buildFilterFaskes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daftar Fasilitas Kesehatan Terdekat',
          style: TextStyle(
            color: Color(0xFF2F6B6A),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildListFaskes() {
    if (_filteredFacilities.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 75),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Tidak ada fasilitas ditemukan',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      );
    }
    return Column(
      children: _filteredFacilities.map((facility) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildInfoFaskes(facility),
        );
      }).toList(),
    );
  }

  Widget _buildInfoFaskes(PetaModel facility) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama + Rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              if (facility.isOpen)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    'Buka',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          facility.rating.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Alamat
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFF40E0D0),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            facility.address,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${facility.distance} dari lokasi Anda',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2F6B6A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Phone
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: Color(0xFF40E0D0),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      facility.phone,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Jam
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFF40E0D0),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      facility.hours,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                height(12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.navigation,
                        label: 'Arah',
                        //SnackBar sementara
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Arah Belum Tersedia'),
                              backgroundColor: const Color(0xFF2F6B6A),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.all(16),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.phone,
                        label: 'Hubungi',
                        onTap: () => _callFacility(facility),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2F6B6A), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: const Color(0xFF2F6B6A)),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2F6B6A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
          Text(
            'Kunjungi posyandu secara rutin setiap bulan untuk pemantauan tumbuh kembang dan konsultasi kesehatan anak gratis.',
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
