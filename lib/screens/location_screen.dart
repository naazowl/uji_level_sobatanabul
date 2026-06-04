// lib/screens/location_screen.dart
// Fix: hapus peta dan tombol Google Maps, tampilkan alamat saja.

import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  static const String _address =
      'Jl. Raya Tajur, Kp. Buntar RT.02/RW.08, Kel. Muara sari, Kec. Bogor Selatan, RT.03/RW.08, Muarasari, Kec. Bogor Sel., Kota Bogor, Jawa Barat 16137';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            // ── TOP BAR ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── LOGO & NAMA ──────────────────────────────────
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C42),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pets, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 12),
            const Text(
              'SobatAnabul',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2B7BB9),
              ),
            ),

            const SizedBox(height: 40),

            // ── LOCATION ICON ────────────────────────────────
            const Icon(Icons.location_on, size: 48, color: Colors.black87),
            const SizedBox(height: 4),
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 24),

            // ── ALAMAT TEXT ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _address,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.7,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}