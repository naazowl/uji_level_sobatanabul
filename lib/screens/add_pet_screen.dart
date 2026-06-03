// lib/screens/add_pet_screen.dart
// Fix: _buildCheckbox sekarang menggunakan InkWell + Material agar area tap
// lebih luas dan reliable. Tidak ada perubahan logika lainnya.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app1/models/pet_model.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _rasController = TextEditingController();
  final _beratController = TextEditingController();
  final _catatanController = TextEditingController();

  // Default kosong agar user WAJIB memilih salah satu
  String? _jenisHewan;
  String _jenisKelamin = 'Jantan';
  XFile? _fotoFile;

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    _rasController.dispose();
    _beratController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _pilihFoto() async {
    final picker = ImagePicker();
    final XFile? picked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() => _fotoFile = picked);
  }

  Widget _buildFoto() {
    if (_fotoFile != null) {
      if (kIsWeb) {
        return Image.network(_fotoFile!.path,
            fit: BoxFit.cover, width: 90, height: 90);
      } else {
        return Image.file(File(_fotoFile!.path),
            fit: BoxFit.cover, width: 90, height: 90);
      }
    }
    return const Icon(Icons.pets, size: 44, color: Color(0xFF2B7BB9));
  }

  void _simpan() {
    if (_namaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama hewan tidak boleh kosong'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Validasi jenis hewan wajib dipilih
    if (_jenisHewan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jenis hewan terlebih dahulu'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final String imgPath = _fotoFile?.path ?? 'assets/images/cello.png';
    final bool isLocal = _fotoFile != null;
    final String berat =
        _beratController.text.isNotEmpty ? '${_beratController.text} kg' : '-';

    final pet = PetModel(
      name: _namaController.text.trim(),
      age: _umurController.text.isNotEmpty ? _umurController.text : '-',
      imagePath: imgPath,
      isLocalFile: isLocal,
      breed: _rasController.text.isNotEmpty ? _rasController.text : '-',
      weight: berat,
      gender: _jenisKelamin,
      specialNotes: _catatanController.text.isNotEmpty
          ? _catatanController.text
          : 'Tidak ada catatan khusus',
      jenisHewan: _jenisHewan!, // ✅ dipastikan tidak null sebelum sampai sini
    );

    Navigator.pop(context, {
      'pet': pet,
      'berat': berat,
      'jenisKelamin': _jenisKelamin,
      'catatan': pet.specialNotes,
      'ras': pet.breed,
      'jenisHewan': _jenisHewan,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ── TOP BAR ───────────────────────────────────────
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: Colors.black),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'SobatAnabul',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2B7BB9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C42),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.pets, color: Colors.white, size: 28),
              ),

              const SizedBox(height: 20),

              // ── FORM CARD ─────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4FD),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // Foto
                    GestureDetector(
                      onTap: _pilihFoto,
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 3),
                            ),
                            child: ClipOval(child: _buildFoto()),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF8C42),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Tap untuk tambah foto',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500)),

                    const SizedBox(height: 16),

                    // ── JENIS HEWAN ─────────────────────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Jenis Hewan:',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildCheckbox('Anjing')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCheckbox('Kucing')),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                _namaController, 'Nama*')),
                        const SizedBox(width: 12),
                        Expanded(
                            child:
                                _buildTextField(_umurController, 'Umur')),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                _rasController, 'Jenis/Ras')),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField(
                                _beratController, 'BB (kg)',
                                keyboardType: TextInputType.number)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Jenis Kelamin:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Expanded(child: _buildToggle('Betina')),
                          Expanded(child: _buildToggle('Jantan')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Catatan Khusus:',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _catatanController,
                        maxLines: 4,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText:
                              'Masukkan catatan medis atau kebiasaan...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: _simpan,
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8C42),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF8C42)
                                  .withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Simpan Profil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── FIX: Gunakan Material + InkWell agar area tap seluruh container ─────────
  Widget _buildCheckbox(String label) {
    final isSelected = _jenisHewan == label;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          setState(() => _jenisHewan = label);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFE8F5E9) // hijau muda jika dipilih
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4CAF50)
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.check_circle_rounded   // lebih jelas dari check_box
                    : Icons.radio_button_unchecked, // lebih jelas dari check_box_outline_blank
                color: isSelected
                    ? const Color(0xFF4CAF50)
                    : Colors.grey.shade400,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? const Color(0xFF2E7D32)
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggle(String label) {
    final isSelected = _jenisKelamin == label;
    final bgColor = label == 'Jantan'
        ? const Color(0xFFB8D8F8)
        : const Color(0xFFFFB8C1);
    final textColor = label == 'Jantan'
        ? const Color(0xFF2B7BB9)
        : const Color(0xFFD63384);
    return GestureDetector(
      onTap: () => setState(() => _jenisKelamin = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isSelected ? textColor : Colors.grey)),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}