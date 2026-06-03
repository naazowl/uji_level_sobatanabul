import 'dart:io'; // 💡 Diperlukan untuk merender file gambar di Android/iOS
import 'package:flutter/foundation.dart'; // 💡 Diperlukan untuk mengecek variabel kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 💡 Mengimport package yang baru ditambahkan

class ProfileScreen extends StatefulWidget {
  // 1. Terima data dari HomeScreen lewat constructor
  final String nama;
  final String email;
  final String username;
  final String alamat;
  final String telepon;
  final String? currentImagePath; // 💡 Menampung path foto lama dari HomeScreen jika ada

  const ProfileScreen({
    super.key,
    required this.nama,
    required this.email,
    required this.username,
    required this.alamat,
    required this.telepon,
    this.currentImagePath, // Tambahkan param opsional ini
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  // 2. Deklarasikan controller tanpa teks default bawaan
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _alamatController;
  late TextEditingController _teleponController;

  // 💡 Deklarasi variabel untuk Image Picker
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // 3. Masukkan data yang dikirim dari HomeScreen ke dalam controller
    _namaController = TextEditingController(text: widget.nama);
    _emailController = TextEditingController(text: widget.email);
    _usernameController = TextEditingController(text: widget.username);
    _teleponController = TextEditingController(text: widget.telepon);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _teleponController.dispose();
    super.dispose();
  }

  // 💡 Fungsi untuk memicu File Manager / Galeri Komputer & HP
  Future<void> _pickImage() async {
    if (!_isEditing) return; // Mengunci input: File Manager hanya terbuka jika statusnya sedang 'Edit Profil'

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, // Membuka file explorer / galeri foto
        imageQuality: 80,            // Mengompres ukuran file gambar
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      debugPrint("Gagal mengambil gambar: $e");
    }
  }

  // 💡 Fungsi pembuat widget gambar profil (mencegah error rendering cross-platform)
  Widget _buildProfileImage() {
    if (_imageFile != null) {
      if (kIsWeb) {
        // Jika berjalan di browser (Chrome/Edge localhost)
        return Image.network(
          _imageFile!.path,
          fit: BoxFit.cover,
          width: 90,
          height: 90,
        );
      } else {
        // Jika berjalan di emulator / HP fisik asli
        return Image.file(
          File(_imageFile!.path),
          fit: BoxFit.cover,
          width: 90,
          height: 90,
        );
      }
    }

    // Jika user punya foto profil lama dari HomeScreen yang dikirim lewat path
    if (widget.currentImagePath != null) {
      if (kIsWeb) {
        return Image.network(widget.currentImagePath!, fit: BoxFit.cover, width: 90, height: 90);
      } else {
        return Image.file(File(widget.currentImagePath!), fit: BoxFit.cover, width: 90, height: 90);
      }
    }

    // Default asset bawaan fallback kalau belum ada modifikasi berkas gambar
    return Image.asset(
      'assets/images/profile.jpg',
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: const Color(0xFFEEE0FF),
        child: const Icon(Icons.person, size: 50, color: Colors.purple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            color: Colors.white,
            child: Column(
              children: [
                // ── TOP BAR ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!_isEditing)
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new,
                              size: 20, color: Colors.black),
                        )
                      else
                        const SizedBox(width: 20),
                      if (_isEditing)
                        GestureDetector(
                          onTap: () {
                            setState(() => _isEditing = false);
                            
                            // 4. PERBAIKAN UTAMA: Kembalikan semua data teks + path gambar baru ke HomeScreen
                            Navigator.pop(context, {
                              'nama': _namaController.text,
                              'email': _emailController.text,
                              'username': _usernameController.text,
                              'alamat': _alamatController.text,
                              'telepon': _teleponController.text,
                              'imagePath': _imageFile?.path ?? widget.currentImagePath, // 💡 Path dikirim balik ke home
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profil berhasil disimpan!'),
                                backgroundColor: Color(0xFF7C5CFC),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Icon(Icons.check,
                              size: 26, color: Colors.black),
                        ),
                    ],
                  ),
                ),

                // ── KONTEN UTAMA ──────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Column(
                            children: [
                              // 💡 Membungkus Avatar menggunakan GestureDetector agar memicu fungsi membuka File Manager
                              GestureDetector(
                                onTap: _pickImage,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color(0xFFE0E0E0), width: 2),
                                      ),
                                      child: ClipOval(
                                        child: _buildProfileImage(), // 💡 Menggunakan UI penangan gambar baru
                                      ),
                                    ),
                                    if (_isEditing)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF7C5CFC),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.camera_alt,
                                              size: 14, color: Colors.white),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '@${_usernameController.text}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (!_isEditing)
                                GestureDetector(
                                  onTap: () => setState(() => _isEditing = true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3D5A80),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Edit Profil',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        _buildField('Nama', _namaController),
                        const SizedBox(height: 20),
                        _buildField('Email', _emailController,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        _buildField('Nama Pengguna', _usernameController),
                        const SizedBox(height: 20),
                        _buildField('Nomor Telepon', _teleponController,
                            keyboardType: TextInputType.phone),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: _isEditing,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF0F4F8),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFF7C5CFC), width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}