// lib/screens/register_screen.dart
// Fix: tambah field Nama Pengguna, kirim email + namaPengguna ke CompleteProfileScreen.

import 'package:flutter/material.dart';
import 'package:app1/screens/complete_profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaPenggunaController = TextEditingController(); // ✅ BARU
  final _passwordController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  bool _showPassword = false;
  bool _showKonfirmasi = false;
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _namaPenggunaController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  void _onDaftar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompleteProfileScreen(
            emailDariAuth: _emailController.text.trim(),
            namaDariAuth: _namaController.text.trim(),
            namaPenggunaDariAuth: _namaPenggunaController.text.trim(), // ✅ BARU
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6ECFA),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),

                        Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF2B7BB9)),
                        ),
                      ),
                    ),

                      Center(child: _LogoWidget()),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF4FB),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Daftar Sekali,\nTitip Berkali-kali!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A2E),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Lengkapi data dirimu dulu ya',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF6B7280)),
                            ),
                            const SizedBox(height: 24),

                            _InputField(
                              controller: _namaController,
                              hint: 'Nama',
                              icon: Icons.person_outline,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Nama tidak boleh kosong'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            _InputField(
                              controller: _emailController,
                              hint: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                                    .hasMatch(v)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // ✅ Field Nama Pengguna BARU
                            _InputField(
                              controller: _namaPenggunaController,
                              hint: 'Nama Pengguna',
                              icon: Icons.alternate_email_rounded,
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Nama pengguna tidak boleh kosong'
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            _InputField(
                              controller: _passwordController,
                              hint: 'Kata sandi',
                              icon: Icons.lock_outline,
                              obscure: !_showPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF9CA3AF),
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                    () => _showPassword = !_showPassword),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Kata sandi tidak boleh kosong';
                                }
                                if (v.length < 6) return 'Minimal 6 karakter';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            _InputField(
                              controller: _konfirmasiController,
                              hint: 'Konfirmasi kata sandi',
                              icon: Icons.lock_outline,
                              obscure: !_showKonfirmasi,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showKonfirmasi
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF9CA3AF),
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                    () => _showKonfirmasi = !_showKonfirmasi),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Konfirmasi tidak boleh kosong';
                                }
                                if (v != _passwordController.text) {
                                  return 'Kata sandi tidak cocok';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _onDaftar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5A623),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 0,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5),
                                      )
                                    : const Text('Daftar',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: RichText(
                                  text: const TextSpan(
                                    text: 'Sudah punya akun? ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280)),
                                    children: [
                                      TextSpan(
                                        text: 'Masuk',
                                        style: TextStyle(
                                          color: Color(0xFF1A1A2E),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: ' disini'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/images/kucing_anjing.png',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              const Icon(Icons.pets, size: 80, color: Color(0xFFF5A623)),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF), size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4A90D9), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5)),
        errorStyle: const TextStyle(fontSize: 11),
      ),
    );
  }
}