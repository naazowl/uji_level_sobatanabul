// lib/screens/titip_screen.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/pet_model.dart';
import 'package:app1/models/riwayat_provider.dart';
import 'package:app1/screens/titip_calendar_screen.dart';

class TitipScreen extends StatefulWidget {
  final List<Map<String, dynamic>> pets;

  const TitipScreen({super.key, required this.pets});

  @override
  State<TitipScreen> createState() => _TitipScreenState();
}

class _TitipScreenState extends State<TitipScreen> {
  int? _selectedIndex;

  Widget _buildPetImage(PetModel pet) {
    const BoxFit fit = BoxFit.contain;
    if (pet.isLocalFile) {
      if (kIsWeb) {
        return Image.network(pet.imagePath, fit: fit);
      } else {
        return Image.file(File(pet.imagePath), fit: fit);
      }
    }
    if (pet.imagePath.startsWith('http')) {
      return Image.network(pet.imagePath, fit: fit);
    }
    return Image.asset(
      pet.imagePath,
      fit: fit,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.pets, size: 50, color: Color(0xFF2B7BB9)),
    );
  }

  void _titipSekarang() {
    final pet = widget.pets[_selectedIndex!]['pet'] as PetModel;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TitipCalendarScreen(
          petName: pet.name,
          petType: widget.pets[_selectedIndex!]['jenisHewan'] ?? 'Hewan',
        ),
      ),
    ).then((result) {
      if (result != null) {
        // ── Catat waktu penitipan ────────────────────────────────────────────
        final now = DateTime.now();
        final provider = RiwayatProvider();

        // Format tanggal: dd/MM/yy HH:mm
        String _fmt(DateTime dt) =>
            '${dt.day.toString().padLeft(2, '0')}/'
            '${dt.month.toString().padLeft(2, '0')}/'
            '${dt.year.toString().substring(2)} '
            '${dt.hour.toString().padLeft(2, '0')}:'
            '${dt.minute.toString().padLeft(2, '0')}';

        // Tambah notifikasi
        provider.tambahNotifikasi({
          'id': now.millisecondsSinceEpoch.toString(),
          'title': 'Hai, ${pet.name} berhasil dititipkan! 🎉',
          'time': _fmt(now),
        });

        // Tambah laporan harian
        provider.tambahLaporan({
          'petName': pet.name,
          'date':
              '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().substring(2)}',
          'mood': 'Baik',
          'activities': <String>[],
        });

        // ── Dialog konfirmasi berhasil ────────────────────────────────────────
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8C42),
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.pets, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Titipan Berhasil! 🎉',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${pet.name} berhasil dititipkan.\nAdmin kami akan segera menghubungi kamu.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // tutup dialog
                    Navigator.pop(context); // kembali ke home
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Kembali ke Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ────────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFFD6EFFA),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,
                              size: 16, color: Colors.black),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Titip',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 36),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '🐾  Pilih hewan yang ingin kamu titipkan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2B7BB9),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── KONTEN ────────────────────────────────────────────────────────
            Expanded(
              child: widget.pets.isEmpty
                  ? _buildKosong(context)
                  : _buildPetGrid(),
            ),

            // ── TOMBOL TITIP SEKARANG ──────────────────────────────────────────
            if (widget.pets.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  children: [
                    if (_selectedIndex != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle,
                                color: Color(0xFF4CAF50), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              '${(widget.pets[_selectedIndex!]['pet'] as PetModel).name} dipilih',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap:
                          _selectedIndex != null ? _titipSekarang : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _selectedIndex != null
                              ? const Color(0xFFFF8C42)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: _selectedIndex != null
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFF8C42)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets,
                              color: _selectedIndex != null
                                  ? Colors.white
                                  : Colors.grey.shade500,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Titip Sekarang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _selectedIndex != null
                                    ? Colors.white
                                    : Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.85,
        ),
        itemCount: widget.pets.length,
        itemBuilder: (context, index) {
          final data = widget.pets[index];
          final pet = data['pet'] as PetModel;
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFFFFF0E0) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF8C42)
                      : Colors.grey.shade200,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? const Color(0xFFFF8C42).withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8C42),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '✓ Dipilih',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    child: Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? const Color(0xFFFF8C42)
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: _buildPetImage(pet),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF8C42).withValues(alpha: 0.1)
                            : const Color(0xFFD6EFFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data['jenisHewan'] ?? 'Hewan',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFFFF8C42)
                              : const Color(0xFF2B7BB9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKosong(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFD6EFFA),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.pets, size: 50, color: Color(0xFF2B7BB9)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Belum ada hewan peliharaan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan hewan peliharaanmu di halaman utama terlebih dahulu',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8C42),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFFFF8C42).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Tambah Hewan Sekarang',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}