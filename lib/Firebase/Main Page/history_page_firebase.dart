import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stuntinq_apps/Firebase/models/child_firebase_model.dart';
import 'package:stuntinq_apps/Firebase/service/firebase_service.dart';

class HistoryFirebase extends StatefulWidget {
  const HistoryFirebase({Key? key}) : super(key: key);

  @override
  State<HistoryFirebase> createState() => _HistoryFirebaseState();
}

class _HistoryFirebaseState extends State<HistoryFirebase> {
  final TextEditingController _searchController = TextEditingController();
  List<ChildHistoryFirebaseModel> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
      _loadHistory();
  }

  Future<void> _loadHistory() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await FirebaseService.getAllHistory(uid);
    setState(() {
      _history = data;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  
  List<ChildHistoryFirebaseModel> get _filteredHistory {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) return _history;

    return _history.where((h) =>
        h.name.toLowerCase().contains(query) ||
        h.age.toString().contains(query) ||
        h.height.toString().contains(query) ||
        h.weight.toString().contains(query)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackground(),
            _buildLayer(),
          ],
        ),
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
     if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2F6B6A)),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildListHistory(),
        ],
      ),
    );
  }

  Widget _buildHeader() { return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
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
          child: const Icon(
            Icons.history,
            color: Color(0xFF2F6B6A),
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Riwayat Pemeriksaan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F6B6A),
              ),
            ),
            Text(
              'Data lengkap riwayat pemeriksaan anak',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ); }

  Widget _buildSearchBar() {return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() {}),
        decoration: InputDecoration(
          hintText: "Cari riwayat...",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
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
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: Color(0xFF2F6B6A),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    ); }

  Widget _buildListHistory() { 
    final list = _filteredHistory;

    if (list.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              "Riwayat tidak ditemukan",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      );
    }

    return Column(
      children: list.map((item) => _buildHistoryCard(item)).toList(),
    );
  }

  Widget _buildHistoryCard(ChildHistoryFirebaseModel item) { 
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF40E0D0).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2F6B6A).withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Color(0xFF2F6B6A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF40E0D0).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${item.age} bln",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2F6B6A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildInfoRow("Tinggi", "${item.height} cm"),
            _buildInfoRow("Berat", "${item.weight} kg"),
            _buildInfoRow("Lingkar Kepala", "${item.head} cm"),
            _buildInfoRow("IMT", item.imt.toStringAsFixed(2)),
            const SizedBox(height: 10),
            Text(
              "Tanggal: ${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: const TextStyle(
                color: Color(0xFF2F6B6A),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
