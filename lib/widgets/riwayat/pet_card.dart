// lib/widgets/riwayat/pet_card.dart
// Fix: cek RiwayatProvider sebelum mengizinkan hapus.
//      Jika hewan sedang dititip (status sedangDititip), tampilkan pesan blokir.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/pet_model.dart';
import 'package:app1/models/riwayat_provider.dart';
import 'package:app1/screens/edit_pet_screen.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;
  final String berat;
  final String jenisKelamin;
  final String catatan;
  final String ras;
  final String jenisHewan;
  final VoidCallback? onDelete;

  const PetCard({
    super.key,
    required this.pet,
    required this.berat,
    required this.jenisKelamin,
    required this.catatan,
    required this.ras,
    required this.jenisHewan,
    this.onDelete,
  });

  Widget _buildPetImage() {
    if (pet.isLocalFile ?? false) {
      if (kIsWeb) {
        return Image.network(pet.imagePath, fit: BoxFit.cover);
      } else {
        return Image.file(File(pet.imagePath), fit: BoxFit.cover);
      }
    }
    return Image.asset(
      pet.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) =>
          const Icon(Icons.pets, size: 40, color: Colors.grey),
    );
  }

  /// Cek apakah hewan ini sedang dalam status penitipan aktif.
  bool _isSedangDititip() {
    final riwayat = RiwayatProvider().items;
    return riwayat.any((item) =>
        item.petName.toLowerCase() == pet.name.toLowerCase() &&
        item.status == StatusTitipan.sedangDititip);
  }

  void _showDeleteDialog(BuildContext context) {
    // ── Blokir hapus jika sedang dititip ──────────────────────────────────
    if (_isSedangDititip()) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.lock_outline_rounded, color: Color(0xFFFF8C42)),
              SizedBox(width: 10),
              Text('Tidak Bisa Dihapus',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          content: Text(
            '${pet.name} sedang dalam penitipan aktif.\n\n'
            'Hewan hanya bisa dihapus setelah masa penitipan selesai.',
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Mengerti',
                  style: TextStyle(
                      color: Color(0xFFFF8C42),
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
      return;
    }

    // ── Dialog konfirmasi hapus normal ────────────────────────────────────
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 10),
              Text('Hapus Data',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          content: Text(
              'Apakah kamu yakin ingin menghapus ${pet.name} dari daftar peliharaan?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                if (onDelete != null) onDelete!();
              },
              child: const Text('Hapus',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sedangDititip = _isSedangDititip();

    return GestureDetector(
      onLongPress: () => _showDeleteDialog(context),
      child: Stack(
        children: [
          Container(
            width: 160,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEFF8),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: _buildPetImage(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A1A)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pet.age,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9E9E9E)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Badge "Sedang Dititip" di pojok kanan atas
          if (sedangDititip)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8C42),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '🐾 Dititip',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════
// DETAIL PET SCREEN
// ════════════════════════════════════════════════════
class DetailPetScreen extends StatefulWidget {
  final PetModel pet;
  final String berat;
  final String jenisKelamin;
  final String catatan;
  final String ras;
  final String jenisHewan;

  const DetailPetScreen({
    super.key,
    required this.pet,
    required this.berat,
    required this.jenisKelamin,
    required this.catatan,
    required this.ras,
    required this.jenisHewan,
  });

  @override
  State<DetailPetScreen> createState() => _DetailPetScreenState();
}

class _DetailPetScreenState extends State<DetailPetScreen> {
  late PetModel _currentPet;
  late String _currentBerat;
  late String _currentJenisKelamin;
  late String _currentCatatan;
  late String _currentRas;
  late String _currentJenisHewan;

  @override
  void initState() {
    super.initState();
    _currentPet = widget.pet;
    _currentBerat = widget.berat;
    _currentJenisKelamin = widget.jenisKelamin;
    _currentCatatan = widget.catatan;
    _currentRas = widget.ras;
    _currentJenisHewan = widget.jenisHewan;
  }

  Widget _buildDetailAvatar() {
    if (_currentPet.isLocalFile ?? false) {
      if (kIsWeb) {
        return Image.network(_currentPet.imagePath, fit: BoxFit.cover);
      } else {
        return Image.file(File(_currentPet.imagePath), fit: BoxFit.cover);
      }
    }
    return Image.asset(
      _currentPet.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) =>
          const Icon(Icons.pets, size: 60, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEFF8),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(120)),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                shape: BoxShape.circle),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  size: 16, color: Colors.black),
                              onPressed: () {
                                Navigator.pop(context, {
                                  'pet': _currentPet,
                                  'berat': _currentBerat,
                                  'jenisKelamin': _currentJenisKelamin,
                                  'catatan': _currentCatatan,
                                  'ras': _currentRas,
                                  'jenisHewan': _currentJenisHewan,
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDBEFF8),
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8))
                      ],
                    ),
                    child: ClipOval(child: _buildDetailAvatar()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              _currentPet.name,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoBox(_currentPet.age, 'Umur'),
                  _buildInfoBox(_currentBerat, 'Berat'),
                  _buildInfoBox(_currentJenisKelamin, 'Jenis\nKelamin'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Catatan Khusus',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 16),
                  _buildNoteTile(
                    icon: Icons.format_list_bulleted_rounded,
                    text: _currentCatatan.isNotEmpty
                        ? _currentCatatan
                        : 'Tidak ada catatan khusus',
                    bgColor: const Color(0xFFFDE8D7),
                    iconBgColor: const Color(0xFFFF8C42),
                  ),
                  const SizedBox(height: 12),
                  _buildNoteTile(
                    icon: Icons.edit_rounded,
                    text: 'Edit data hewan',
                    bgColor: const Color(0xFFE0D9FF),
                    iconBgColor: const Color(0xFF7C5CFC),
                    onTap: () async {
                      final Map<String, dynamic>? hasilEdit =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPetScreen(
                            pet: _currentPet,
                            nama: _currentPet.name,
                            umur: _currentPet.age,
                            ras: _currentRas,
                            berat: _currentBerat,
                            jenisKelamin: _currentJenisKelamin,
                            catatan: _currentCatatan,
                            jenisHewan: _currentJenisHewan,
                          ),
                        ),
                      );

                      if (hasilEdit != null) {
                        setState(() {
                          if (hasilEdit['pet'] != null) {
                            _currentPet = hasilEdit['pet'] as PetModel;
                          }
                          _currentBerat = _currentPet.weight ?? _currentBerat;
                          _currentJenisKelamin =
                              _currentPet.gender ?? _currentJenisKelamin;
                          _currentCatatan =
                              _currentPet.specialNotes ?? _currentCatatan;
                          _currentRas = hasilEdit['ras'] ??
                              _currentPet.breed ??
                              _currentRas;
                          _currentJenisHewan =
                              hasilEdit['jenisHewan'] ?? _currentJenisHewan;
                        });

                        if (context.mounted) {
                          Navigator.pop(context, hasilEdit);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFDBEFF8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03), blurRadius: 10)
          ],
        ),
        child: Column(
          children: [
            Text(value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF1A1A1A))),
            const SizedBox(height: 4),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF6F777A),
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteTile({
    required IconData icon,
    required String text,
    required Color bgColor,
    required Color iconBgColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A))),
            ),
          ],
        ),
      ),
    );
  }
}