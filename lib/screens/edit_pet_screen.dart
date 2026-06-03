import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app1/models/pet_model.dart';

class EditPetScreen extends StatefulWidget {
  final PetModel pet;
  final String nama;
  final String umur;
  final String ras;
  final String berat;
  final String jenisKelamin;
  final String catatan;
  final String jenisHewan;
  final String? fotoPathAwal;    
  final bool isFotoLocalAwal;    

  const EditPetScreen({
    super.key,
    required this.pet,
    this.nama = '',
    this.umur = '',
    this.ras = '',
    this.berat = '',
    this.jenisKelamin = '',
    this.catatan = '',
    this.jenisHewan = 'Anjing',
    this.fotoPathAwal,
    this.isFotoLocalAwal = false,
  });

  @override
  State<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  late TextEditingController _namaController;
  late TextEditingController _umurController;
  late TextEditingController _rasController;
  late TextEditingController _beratController;
  late TextEditingController _catatanController;

  late String _jenisHewan;
  late String _jenisKelamin;

  XFile? _fotoBaruFile;        
  String? _fotoPathLama;       
  bool _isFotoLokaLama = false; 

  @override
  void initState() {
    super.initState();
    // Prioritaskan mengisi textfield dari properti pet yang diklik biar gak kosong
    _namaController = TextEditingController(text: widget.nama.isNotEmpty ? widget.nama : widget.pet.name);
    _umurController = TextEditingController(text: widget.umur.isNotEmpty ? widget.umur : widget.pet.age);
    _rasController = TextEditingController(text: widget.ras.isNotEmpty ? widget.ras : (widget.pet.breed ?? '-'));
    _beratController = TextEditingController(text: widget.berat.isNotEmpty ? widget.berat : (widget.pet.weight ?? '30'));
    _catatanController = TextEditingController(text: widget.catatan.isNotEmpty ? widget.catatan : (widget.pet.specialNotes ?? ''));
    
    _jenisKelamin = widget.jenisKelamin.isNotEmpty ? widget.jenisKelamin : (widget.pet.gender ?? 'Jantan');
    _jenisHewan = widget.jenisHewan;

    _fotoPathLama = widget.fotoPathAwal ?? widget.pet.imagePath;
    _isFotoLokaLama = widget.fotoPathAwal != null ? widget.isFotoLocalAwal : (widget.pet.isLocalFile ?? false);
  }

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
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() => _fotoBaruFile = picked);
  }

  Widget _buildFotoHewan() {
    if (_fotoBaruFile != null) {
      if (kIsWeb) {
        return Image.network(_fotoBaruFile!.path, fit: BoxFit.cover, width: 90, height: 90);
      } else {
        return Image.file(File(_fotoBaruFile!.path), fit: BoxFit.cover, width: 90, height: 90);
      }
    }

    if (_fotoPathLama != null) {
      if (_isFotoLokaLama) {
        if (kIsWeb) {
          return Image.network(_fotoPathLama!, fit: BoxFit.cover, width: 90, height: 90);
        } else {
          return Image.file(File(_fotoPathLama!), fit: BoxFit.cover, width: 90, height: 90);
        }
      }
    }

    return Image.asset(
      widget.pet.imagePath,
      fit: BoxFit.cover,
      width: 90, height: 90,
      errorBuilder: (_, _, _) => const Icon(Icons.pets, size: 40, color: Color(0xFF2B7BB9)),
    );
  }

  void _simpan() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama hewan tidak boleh kosong')));
      return;
    }

    final String finalFotoPath = _fotoBaruFile?.path ?? _fotoPathLama ?? widget.pet.imagePath;
    final bool finalIsLocal = _fotoBaruFile != null ? true : _isFotoLokaLama;

    // Bungkus semua perubahan baru ke model objek PetModel
    final updatedPet = PetModel(
      name: _namaController.text,
      age: _umurController.text.isNotEmpty ? _umurController.text : '-',
      imagePath: finalFotoPath,
      isLocalFile: finalIsLocal,
      breed: _rasController.text,
      weight: _beratController.text,
      gender: _jenisKelamin,
      specialNotes: _catatanController.text.isNotEmpty ? _catatanController.text : 'Tidak ada catatan khusus',
    );

    // Kembalikan map berisi objek 'pet' terbaru ke DetailPetScreen
    Navigator.pop(context, {
      'pet': updatedPet,
      'jenisHewan': _jenisHewan,
      'ras': _rasController.text,
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
              const SizedBox(height: 24),
              Column(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: const BoxDecoration(color: Color(0xFFFF8C42), shape: BoxShape.circle),
                    child: const Icon(Icons.pets, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 8),
                  const Text('SobatAnabul', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2B7BB9))),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFE8F4FD), borderRadius: BorderRadius.circular(24)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pilihFoto,
                      child: Stack(
                        children: [
                          Container(
                            width: 90, height: 90,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.white, width: 3)),
                            child: ClipOval(child: _buildFotoHewan()),
                          ),
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              width: 28, height: 28,
                              decoration: const BoxDecoration(color: Color(0xFFFF8C42), shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Tap foto untuk mengganti', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                    const SizedBox(height: 16),
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
                        Expanded(child: _buildTextField(_namaController, 'Nama')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField(_umurController, 'Umur')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_rasController, 'Ras')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField(_beratController, 'Berat')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Jenis Kelamin:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
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
                      child: Text('Catatan Khusus:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: _catatanController,
                        maxLines: 4,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Tambahkan catatan khusus...',
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8C42),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: const Color(0xFFFF8C42).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        child: const Text('Simpan Profil', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
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

  Widget _buildCheckbox(String label) {
    final isSelected = _jenisHewan == label;
    return GestureDetector(
      onTap: () => setState(() => _jenisHewan = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF4CAF50) : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank, color: isSelected ? const Color(0xFF4CAF50) : Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String label) {
    final isSelected = _jenisKelamin == label;
    final bgColor = label == 'Jantan' ? const Color(0xFFB8D8F8) : const Color(0xFFFFB8C1);
    final textColor = label == 'Jantan' ? const Color(0xFF2B7BB9) : const Color(0xFFD63384);
    return GestureDetector(
      onTap: () => setState(() => _jenisKelamin = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: isSelected ? bgColor : Colors.transparent, borderRadius: BorderRadius.circular(30)),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, color: isSelected ? textColor : Colors.grey)),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}