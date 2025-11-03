// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui';

// /// Model untuk Health Facility
// class HealthFacility {
//   final int id;
//   final String name;
//   final String type;
//   final String distance;
//   final String address;
//   final String phone;
//   final String hours;
//   final double rating;
//   final bool isOpen;

//   HealthFacility({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.distance,
//     required this.address,
//     required this.phone,
//     required this.hours,
//     required this.rating,
//     required this.isOpen,
//   });
// }

// /// Halaman Peta Fasilitas Kesehatan Terdekat
// /// Menampilkan daftar fasilitas kesehatan dengan peta interaktif
// class HealthFacilitiesMapPage extends StatefulWidget {
//   const HealthFacilitiesMapPage({Key? key}) : super(key: key);

//   @override
//   State<HealthFacilitiesMapPage> createState() => _HealthFacilitiesMapPageState();
// }

// class _HealthFacilitiesMapPageState extends State<HealthFacilitiesMapPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _selectedFilter = 'Semua';
  
//   // Mock data - Replace with actual data from API/Database
//   final List<HealthFacility> _allFacilities = [
//     HealthFacility(
//       id: 1,
//       name: 'Puskesmas Kelapa Dua',
//       type: 'Puskesmas',
//       distance: '0.8 km',
//       address: 'Jl. Kelapa Dua No. 12, Jakarta Barat',
//       phone: '021-5555-1234',
//       hours: '08:00 - 16:00',
//       rating: 4.5,
//       isOpen: true,
//     ),
//     HealthFacility(
//       id: 2,
//       name: 'Posyandu Melati',
//       type: 'Posyandu',
//       distance: '1.2 km',
//       address: 'Jl. Melati Raya No. 45, Jakarta Barat',
//       phone: '021-5555-5678',
//       hours: '08:00 - 12:00',
//       rating: 4.3,
//       isOpen: true,
//     ),
//     HealthFacility(
//       id: 3,
//       name: 'RS Harapan Sehat',
//       type: 'Rumah Sakit',
//       distance: '2.5 km',
//       address: 'Jl. Kesehatan No. 88, Jakarta Barat',
//       phone: '021-5555-9012',
//       hours: '24 Jam',
//       rating: 4.7,
//       isOpen: true,
//     ),
//     HealthFacility(
//       id: 4,
//       name: 'Klinik Pratama Sejahtera',
//       type: 'Klinik',
//       distance: '1.8 km',
//       address: 'Jl. Sejahtera No. 23, Jakarta Barat',
//       phone: '021-5555-3456',
//       hours: '07:00 - 21:00',
//       rating: 4.4,
//       isOpen: true,
//     ),
//   ];

//   List<HealthFacility> get _filteredFacilities {
//     List<HealthFacility> filtered = _allFacilities;
    
//     // Filter by type
//     if (_selectedFilter != 'Semua') {
//       filtered = filtered.where((f) => f.type == _selectedFilter).toList();
//     }
    
//     // Filter by search query
//     if (_searchController.text.isNotEmpty) {
//       filtered = filtered.where((f) =>
//         f.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
//         f.address.toLowerCase().contains(_searchController.text.toLowerCase())
//       ).toList();
//     }
    
//     return filtered;
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF2F6B6A),
//               Color(0xFFF8FAFB),
//             ],
//             stops: [0.0, 0.3],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Header
//               _buildHeader(),
              
//               // Scrollable Content
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       // Search Bar
//                       _buildSearchBar(),
//                       const SizedBox(height: 16),
                      
//                       // Map Placeholder
//                       _buildMapPlaceholder(),
//                       const SizedBox(height: 20),
                      
//                       // Filter & List Header
//                       _buildListHeader(),
//                       const SizedBox(height: 12),
                      
//                       // Facilities List
//                       _buildFacilitiesList(),
//                       const SizedBox(height: 16),
                      
//                       // Tips Card
//                       _buildTipsCard(),
//                       const SizedBox(height: 100), // Space for bottom navigation
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   const Color(0xFF40E0D0).withOpacity(0.3),
//                   const Color(0xFF2F6B6A).withOpacity(0.3),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF2F6B6A).withOpacity(0.2),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: const Icon(
//               Icons.local_hospital_rounded,
//               color: Color(0xFF2F6B6A),
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Fasilitas Kesehatan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   '${_filteredFacilities.length} fasilitas terdekat',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) => setState(() {}),
//         style: const TextStyle(fontSize: 14),
//         decoration: InputDecoration(
//           hintText: 'Cari fasilitas kesehatan...',
//           hintStyle: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 14,
//           ),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Colors.grey[400],
//             size: 20,
//           ),
//           suffixIcon: Icon(
//             Icons.navigation,
//             color: Colors.grey[400],
//             size: 18,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(
//               color: const Color(0xFF40E0D0).withOpacity(0.3),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(
//               color: const Color(0xFF40E0D0).withOpacity(0.3),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: const BorderSide(
//               color: Color(0xFF2F6B6A),
//               width: 2,
//             ),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMapPlaceholder() {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             const Color(0xFF40E0D0).withOpacity(0.2),
//             const Color(0xFF2F6B6A).withOpacity(0.2),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color(0xFF40E0D0).withOpacity(0.3),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF2F6B6A).withOpacity(0.15),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Center content
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.map_outlined,
//                     size: 40,
//                     color: Color(0xFF2F6B6A),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Text(
//                   'Peta Interaktif',
//                   style: TextStyle(
//                     color: Color(0xFF2F6B6A),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Lokasi Anda dan fasilitas terdekat',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Location badge
//           Positioned(
//             top: 12,
//             left: 12,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   Text(
//                     '📍',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                   SizedBox(width: 6),
//                   Text(
//                     'Lokasi Anda',
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildListHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Daftar Fasilitas',
//           style: TextStyle(
//             color: Color(0xFF2F6B6A),
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         GestureDetector(
//           onTap: _showFilterDialog,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFF40E0D0).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: const [
//                 Icon(
//                   Icons.filter_list,
//                   size: 16,
//                   color: Color(0xFF2F6B6A),
//                 ),
//                 SizedBox(width: 6),
//                 Text(
//                   'Filter',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF2F6B6A),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFacilitiesList() {
//     if (_filteredFacilities.isEmpty) {
//       return Container(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           children: [
//             Icon(
//               Icons.search_off,
//               size: 48,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Tidak ada fasilitas ditemukan',
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
    
//     return Column(
//       children: _filteredFacilities.map((facility) {
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: _buildFacilityCard(facility),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildFacilityCard(HealthFacility facility) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color(0xFF40E0D0).withOpacity(0.2),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => _showFacilityDetails(facility),
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header with name and rating
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             facility.name,
//                             style: const TextStyle(
//                               color: Color(0xFF2F6B6A),
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Row(
//                             children: [
//                               _buildTypeBadge(facility.type),
//                               const SizedBox(width: 8),
//                               if (facility.isOpen)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 4,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: const Text(
//                                     'Buka',
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.star,
//                           size: 16,
//                           color: Colors.amber,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           facility.rating.toString(),
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
                
//                 // Address
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(
//                       Icons.location_on_outlined,
//                       size: 16,
//                       color: Color(0xFF40E0D0),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             facility.address,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             '${facility.distance} dari lokasi Anda',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF2F6B6A),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
                
//                 // Phone
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.phone_outlined,
//                       size: 16,
//                       color: Color(0xFF40E0D0),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       facility.phone,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
                
//                 // Hours
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.access_time,
//                       size: 16,
//                       color: Color(0xFF40E0D0),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       facility.hours,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
                
//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.navigation,
//                         label: 'Arah',
//                         onTap: () => _openDirections(facility),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _buildActionButton(
//                         icon: Icons.phone,
//                         label: 'Hubungi',
//                         onTap: () => _callFacility(facility),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTypeBadge(String type) {
//     Color backgroundColor;
//     Color textColor;
    
//     switch (type) {
//       case 'Puskesmas':
//         backgroundColor = Colors.blue.withOpacity(0.1);
//         textColor = Colors.blue;
//         break;
//       case 'Posyandu':
//         backgroundColor = Colors.green.withOpacity(0.1);
//         textColor = Colors.green;
//         break;
//       case 'Rumah Sakit':
//         backgroundColor = Colors.red.withOpacity(0.1);
//         textColor = Colors.red;
//         break;
//       case 'Klinik':
//         backgroundColor = Colors.purple.withOpacity(0.1);
//         textColor = Colors.purple;
//         break;
//       default:
//         backgroundColor = Colors.grey.withOpacity(0.1);
//         textColor = Colors.grey;
//     }
    
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         type,
//         style: TextStyle(
//           fontSize: 11,
//           color: textColor,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       height: 40,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color(0xFF2F6B6A),
//           width: 1.5,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             HapticFeedback.lightImpact();
//             onTap();
//           },
//           borderRadius: BorderRadius.circular(10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 16,
//                 color: const Color(0xFF2F6B6A),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF2F6B6A),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTipsCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF40E0D0).withOpacity(0.1),
//             const Color(0xFF2F6B6A).withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: const Color(0xFF40E0D0).withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF40E0D0).withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Text(
//                   '💡',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'Tips',
//                 style: TextStyle(
//                   color: Color(0xFF2F6B6A),
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             'Kunjungi posyandu secara rutin setiap bulan untuk pemantauan tumbuh kembang dan konsultasi kesehatan anak gratis.',
//             style: TextStyle(
//               color: const Color(0xFF2F6B6A).withOpacity(0.8),
//               fontSize: 12,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showFilterDialog() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateModal) {
//             return Container(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Handle bar
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
                  
//                   const Text(
//                     'Filter Tipe Fasilitas',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2F6B6A),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
                  
//                   _buildFilterOption('Semua', setStateModal),
//                   _buildFilterOption('Puskesmas', setStateModal),
//                   _buildFilterOption('Posyandu', setStateModal),
//                   _buildFilterOption('Rumah Sakit', setStateModal),
//                   _buildFilterOption('Klinik', setStateModal),
                  
//                   const SizedBox(height: 16),
                  
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         setState(() {});
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2F6B6A),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Terapkan Filter'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildFilterOption(String option, StateSetter setStateModal) {
//     final isSelected = _selectedFilter == option;
    
//     return GestureDetector(
//       onTap: () {
//         setStateModal(() {
//           _selectedFilter = option;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: isSelected 
//             ? const Color(0xFF40E0D0).withOpacity(0.1)
//             : Colors.grey.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected 
//               ? const Color(0xFF40E0D0)
//               : Colors.grey.withOpacity(0.2),
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               isSelected ? Icons.check_circle : Icons.circle_outlined,
//               color: isSelected ? const Color(0xFF40E0D0) : Colors.grey,
//               size: 22,
//             ),
//             const SizedBox(width: 12),
//             Text(
//               option,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 color: isSelected ? const Color(0xFF2F6B6A) : Colors.grey[700],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showFacilityDetails(HealthFacility facility) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Handle bar
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
              
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       facility.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2F6B6A),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 18, color: Colors.amber),
//                       const SizedBox(width: 4),
//                       Text(
//                         facility.rating.toString(),
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
              
//               _buildDetailRow(Icons.category_outlined, 'Tipe', facility.type),
//               _buildDetailRow(Icons.location_on_outlined, 'Alamat', facility.address),
//               _buildDetailRow(Icons.directions_outlined, 'Jarak', facility.distance),
//               _buildDetailRow(Icons.phone_outlined, 'Telepon', facility.phone),
//               _buildDetailRow(Icons.access_time, 'Jam Operasional', facility.hours),
              
//               const SizedBox(height: 20),
              
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _openDirections(facility);
//                         },
//                         icon: const Icon(Icons.navigation),
//                         label: const Text('Arah'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2F6B6A),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: OutlinedButton.icon(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _callFacility(facility);
//                         },
//                         icon: const Icon(Icons.phone),
//                         label: const Text('Hubungi'),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: const Color(0xFF2F6B6A),
//                           side: const BorderSide(
//                             color: Color(0xFF2F6B6A),
//                             width: 2,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             size: 18,
//             color: const Color(0xFF40E0D0),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF2F6B6A),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _openDirections(HealthFacility facility) {
//     // TODO: Integrate with Google Maps or similar
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.navigation, color: Colors.white, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text('Membuka arah ke ${facility.name}'),
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xFF2F6B6A),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   void _callFacility(HealthFacility facility) {
//     // TODO: Implement phone call using url_launcher
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.phone, color: Colors.white, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text('Memanggil ${facility.phone}'),
//             ),
//           ],
//         ),
//         backgroundColor: const Color(0xFF2F6B6A),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
// }
