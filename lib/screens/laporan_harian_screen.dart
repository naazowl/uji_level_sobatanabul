// lib/screens/laporan_harian_screen.dart

import 'package:flutter/material.dart';
import 'package:app1/models/riwayat_provider.dart';
import 'package:intl/intl.dart'; // Pastikan sudah install intl di pubspec.yaml untuk format tanggal

class LaporanHarianScreen extends StatefulWidget {
  final List<dynamic> pets;

  const LaporanHarianScreen({super.key, this.pets = const []});

  @override
  State<LaporanHarianScreen> createState() => _LaporanHarianScreenState();
}

class _LaporanHarianScreenState extends State<LaporanHarianScreen> {
  // ── DATA AKTIVITAS & FOTO KUCING ──────────────────────────────────────────
  final List<Map<String, String>> catPhotos = [
    {'assetPath': 'assets/images/mandi.jpg', 'title': 'Mandi 08:00'},
    {'assetPath': 'assets/images/makan.jpg', 'title': 'Makan 09:00'},
    {'assetPath': 'assets/images/bermain.jpg', 'title': 'Bermain 10:00'},
    {'assetPath': 'assets/images/tidur.webp', 'title': 'Tidur Siang 12:00'},
    {'assetPath': 'assets/images/jalan.jpg', 'title': 'Jalan Sore 16:00'},
  ];

  final List<Map<String, dynamic>> catActivities = [
    {'name': 'Mandi', 'color': const Color(0xFFFFB3B3)},
    {'name': 'Makan', 'color': const Color(0xFFE1BEE7)},
    {'name': 'Bermain', 'color': const Color(0xFFC8E6C9)},
    {'name': 'Tidur Siang', 'color': const Color(0xFFFFE0B2)},
    {'name': 'Jalan Sore', 'color': const Color(0xFFFFF9C4)},
  ];

  // ── DATA AKTIVITAS & FOTO ANJING ──────────────────────────────────────────
  final List<Map<String, String>> dogPhotos = [
    {'assetPath': 'assets/images/mandi_anjing.jpg', 'title': 'Mandi Pagi 07:30'},
    {'assetPath': 'assets/images/makan_anjing.jpg', 'title': 'Makan Pagi 08:30'},
    {'assetPath': 'assets/images/jalan_anjing.jpg', 'title': 'Jalan Pagi 09:30'},
    {'assetPath': 'assets/images/main_bola.jpg', 'title': 'Main Lempar Bola 15:30'},
    {'assetPath': 'assets/images/tidur_anjing.webp', 'title': 'Tidur 19:00'},
  ];

  final List<Map<String, dynamic>> dogActivities = [
    {'name': 'Mandi Pagi', 'color': const Color(0xFFB3E5FC)},
    {'name': 'Makan Pagi', 'color': const Color(0xFFDCEDC8)},
    {'name': 'Jalan Pagi', 'color': const Color(0xFFFFF9C4)},
    {'name': 'Main Lempar Bola', 'color': const Color(0xFFFFCC80)},
    {'name': 'Tidur', 'color': const Color(0xFFD1C4E9)},
  ];

  @override
  Widget build(BuildContext context) {
    const Color aestheticDarkText = Color(0xFF1E293B);
    const Color aestheticBlueAccent = Color(0xFF4F93E3);
    const Color subTextColor = Color(0xFF64748B);

    // Filter hanya hewan yang berstatus "sedangDititip" saat ini
    final List<RiwayatItem> activePets = RiwayatProvider()
        .items
        .where((item) => item.status == StatusTitipan.sedangDititip)
        .toList();

    // Jika tidak ada hewan yang sedang dititipkan, tampilkan halaman kosong
    if (activePets.isEmpty) {
      return _buildEmptyLaporan(context, aestheticDarkText);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: aestheticDarkText, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Laporan Harian',
          style: TextStyle(
            color: aestheticDarkText,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            fontFamily: 'Nunito',
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: activePets.length,
        padding: const EdgeInsets.only(bottom: 24),
        itemBuilder: (context, petIndex) {
          final pet = activePets[petIndex];
          
          // Cek tipe hewan (lowercase untuk menghindari typo Kucing/kucing)
          final bool isDog = pet.petType.toLowerCase() == 'anjing';
          final currentPhotos = isDog ? dogPhotos : catPhotos;
          final currentActivities = isDog ? dogActivities : catActivities;
          
          // Format tanggal hari ini
          final String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

          return Card(
            color: Colors.transparent,
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pembatas antar hewan jika lebih dari satu
                if (petIndex > 0)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(
                      color: Color(0xFFFFE2E8F0),
                      thickness: 1.5,
                    ),
                  ),

                // ── HEADER: Nama Hewan, Tanggal & Mood ──────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${pet.petName} (${pet.petType})',
                            style: const TextStyle(
                              color: subTextColor,
                              fontSize: 14,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              color: aestheticDarkText,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      // Mood Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFBAE6FD), width: 1),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.wb_sunny_rounded, color: aestheticBlueAccent, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Mood: Baik',
                              style: TextStyle(
                                color: Color(0xFF0369A1),
                                fontSize: 13,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── SLIDER FOTO ──────────────────────────────────────────────────
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: currentPhotos.length,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 170,
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF0F172A).withOpacity(0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    currentPhotos[index]['assetPath']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: const Color(0xFFF1F5F9),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.insert_photo_outlined,
                                                color: Colors.grey[400], size: 28),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Missing asset:\n${currentPhotos[index]['assetPath']}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 9,
                                                fontFamily: 'Nunito',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                currentPhotos[index]['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: aestheticDarkText,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // ── AKTIVITAS TERPENUHI ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 18,
                            decoration: BoxDecoration(
                              color: aestheticBlueAccent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Aktivitas Terpenuhi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: aestheticDarkText,
                              fontFamily: 'Nunito',
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: currentActivities.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0F172A).withOpacity(0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: (currentActivities[index]['color'] as Color).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check_circle_rounded,
                                      size: 18,
                                      color: currentActivities[index]['color'] as Color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  currentActivities[index]['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nunito',
                                    color: aestheticDarkText,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Selesai',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[400],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── HALAMAN KOSONG SEBELUM ADA PENITIPAN ──────────────────────────────────
  Widget _buildEmptyLaporan(BuildContext context, Color aestheticDarkText) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: aestheticDarkText, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Laporan Harian',
          style: TextStyle(
            color: aestheticDarkText,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            fontFamily: 'Nunito',
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.assignment_outlined,
                  size: 44,
                  color: Color(0xFF93C5FD),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Belum Ada Laporan',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: aestheticDarkText,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Laporan harian akan otomatis muncul setelah kamu melakukan penitipan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  height: 1.5,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}