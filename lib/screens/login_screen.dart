// lib/screens/login_screen.dart
// Fix: pass email ke CompleteProfileScreen setelah masuk.

import 'package:flutter/material.dart';
import 'package:app1/screens/forget_password_screen.dart';
import 'package:app1/screens/register_screen.dart';
import 'package:app1/screens/complete_profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onMasuk() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteProfileScreen(
          // ✅ Kirim email dari form login
          emailDariAuth: _emailController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        // Setelah const SizedBox(height: 30), tambahkan:
                        Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 38,
                          height: 38,
                          // Memberikan jarak luar khusus di bagian kiri container saja
                          margin: const EdgeInsets.only(left: 16.0), 
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
                        ),
                      ),
                    ),

                        Center(
                          child: Image.asset(
                            'assets/images/kucing_anjing.png',
                            height: 140,
                            errorBuilder: (_, __, ___) => const Icon(
                                Icons.pets,
                                size: 80,
                                color: Color(0xFFFF8C42)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 20.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ayo Masuk!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Biar anabul cepet beres.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Center(
                                  child: Text(
                                    'Lengkapi data dirimu dulu ya',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // ── Email ──────────────────────────
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty)
                                      return 'Email tidak boleh kosong';
                                    if (!RegExp(
                                            r'^[\w\.-]+@[\w\.-]+\.\w+$')
                                        .hasMatch(v))
                                      return 'Format email tidak valid';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.5),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // ── Kata Sandi ─────────────────────
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_showPassword,
                                  validator: (v) {
                                    if (v == null || v.isEmpty)
                                      return 'Kata sandi tidak boleh kosong';
                                    if (v.length < 6)
                                      return 'Minimal 6 karakter';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Kata sandi',
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                      onPressed: () => setState(() =>
                                          _showPassword = !_showPassword),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1.5),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                  ),
                                ),

                                // ── Lupa Kata Sandi ────────────────
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Lupa kata sandi?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // ── Tombol Masuk ───────────────────
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _onMasuk,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // ── Link Register ──────────────────
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Text('Belum punya akun? '),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Daftar disini',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
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
          },
        ),
      ),
    );
  }
}