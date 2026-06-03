// lib/screens/complete_profile_screen.dart
// Fix: email diisi otomatis dari login/daftar.
//      Jika user mengubah email ke yang berbeda, muncul error merah.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app1/screens/home_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  /// Email yang dipakai saat login atau daftar.
  final String emailDariAuth;

  /// Nama dari form daftar (opsional, hanya dari RegisterScreen).
  final String? namaDariAuth;

  /// Nama pengguna dari form daftar (opsional).
  final String? namaPenggunaDariAuth;

  const CompleteProfileScreen({
    super.key,
    required this.emailDariAuth,
    this.namaDariAuth,
    this.namaPenggunaDariAuth,
  });

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaPenggunaController = TextEditingController();
  final _teleponController = TextEditingController();

  String? _imagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // ✅ Isi otomatis email & nama dari halaman sebelumnya
    _emailController.text = widget.emailDariAuth;
    if (widget.namaDariAuth != null && widget.namaDariAuth!.isNotEmpty) {
      _namaController.text = widget.namaDariAuth!;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _namaPenggunaController.dispose();
    _teleponController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _imagePath = picked.path);
  }

  void _onSimpan() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            namaAwal: _namaController.text.trim(),
            emailAwal: _emailController.text.trim(),
            usernameAwal: _namaPenggunaController.text.trim(),
            teleponAwal: _teleponController.text.trim(),
            imagePathAwal: _imagePath,
          ),
        ),
        (route) => false,
      );
    }
  }

  Widget _buildAvatar() {
    Widget foto;
    if (_imagePath != null) {
      foto = kIsWeb
          ? Image.network(_imagePath!,
              fit: BoxFit.cover, width: 96, height: 96)
          : Image.file(File(_imagePath!),
              fit: BoxFit.cover, width: 96, height: 96);
    } else {
      foto = const Icon(Icons.person, size: 52, color: Color(0xFFBDBDBD));
    }

    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFE0E0E0),
              child: ClipOval(
                child: SizedBox(width: 96, height: 96, child: foto),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5A623),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt,
                    size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _buildAvatar(),
                const SizedBox(height: 32),

                _buildLabel('Nama'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _namaController,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),

                // ── Email: terisi otomatis, wajib sama dengan saat auth ──
                _buildLabel('Email'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Email wajib diisi';
                    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(v))
                      return 'Format email tidak valid';
                    // ✅ Validasi harus sama dengan email saat login/daftar
                    if (v.trim() != widget.emailDariAuth) {
                      return 'Email harus sama dengan yang digunakan saat masuk/daftar';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildLabel('Nama Pengguna'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _namaPenggunaController,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Nama pengguna wajib diisi';
                    if (widget.namaPenggunaDariAuth != null &&
                        widget.namaPenggunaDariAuth!.isNotEmpty &&
                        v.trim() != widget.namaPenggunaDariAuth) {
                      return 'Nama pengguna harus sama dengan yang didaftarkan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildLabel('Nomor Telepon'),
                const SizedBox(height: 8),
                _buildField(
                  controller: _teleponController,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nomor telepon wajib diisi'
                      : null,
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSimpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A623),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            'Simpan',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1A1A2E),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Color(0xFFF5A623), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.red, width: 1.5)),
        errorStyle: const TextStyle(fontSize: 11),
        errorMaxLines: 2,
      ),
    );
  }
}