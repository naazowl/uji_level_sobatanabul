// lib/screens/welcome_screen.dart
// Fix: tambah tombol back ke OnboardingScreen.

import 'package:flutter/material.dart';
import 'package:app1/screens/login_screen.dart';
import 'package:app1/screens/register_screen.dart';
import 'package:app1/screens/onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EFFA),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Lingkaran dekoratif background ──────────────────────────
            Positioned(
              top: -40, right: -40,
              child: Container(
                width: 160, height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
            Positioned(
              top: 80, left: -30,
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.18),
                ),
              ),
            ),
            Positioned(
              bottom: 200, right: -20,
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),

            // ── Konten utama ─────────────────────────────────────────────
SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          // Memaksa tinggi konten minimal seukuran layar agar susunan tidak rusak
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: IntrinsicHeight( // Mengizinkan widget Expanded/Flexible bekerja di dalam scroll
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // ✅ Tombol back ke Onboarding
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnboardingScreen()),
                      ),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Color(0xFF2B7BB9),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10), // Beri sedikit jarak atas
                        Image.asset(
                          'assets/images/kucing_anjing.png',
                          height: 180, // Sedikit diperkecil agar lebih aman di layar pendek
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.pets,
                            size: 100,
                            color: Color(0xFF2B7BB9),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'SobatAnabul',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2B7BB9),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Penitipan Nyaman, Perawatan Maksimal.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2B7BB9).withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // ── Card tombol Masuk / Daftar ───────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Titip & rawat anabul?\nTinggal klik, langsung beres!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A2E),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Tombol Masuk
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: const Color(0xFF2B7BB9), width: 1.5),
                            ),
                            child: const Text(
                              'Masuk',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2B7BB9),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tombol Daftar
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen()),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A2E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'Daftar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24), // Diperkecil dari 32 ke 24 agar pas
                ],
              ),
            ),
          ),
        ),
      );
    },
  ),
)
          ],
        ),
      ),
    );
  }
}