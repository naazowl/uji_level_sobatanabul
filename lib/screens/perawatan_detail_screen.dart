import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

class _PerawatanData {
  final String kategori;
  final String deskripsi;
  final List<String> imagePaths; // ← pakai asset lokal
  final Color bgColor;
  final String emoji;

  const _PerawatanData({
    required this.kategori,
    required this.deskripsi,
    required this.imagePaths,
    required this.bgColor,
    required this.emoji,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// GANTI PATH FOTO DI SINI sesuai nama file foto Anda di assets/images/
// Masing-masing kategori punya 3 slot foto
// ─────────────────────────────────────────────────────────────────────────────
final Map<String, _PerawatanData> _dataMap = {
  'Kebutuhan Dasar': _PerawatanData(
    kategori: 'Kebutuhan Dasar',
    emoji: '🍽️',
    bgColor: AppColors.iconBlueBg,
    deskripsi:
        'Kami memastikan kebutuhan dasar hewan kesayanganmu terpenuhi dengan baik setiap hari. Mulai dari pemberian makan dan minum sesuai jadwal, pengaturan porsi yang tepat, hingga menjaga kebersihan kandang dan tubuh.\n\nSemua dilakukan dengan penuh perhatian agar hewan tetap sehat, bersih, dan nyaman.',
    imagePaths: [
      'assets/images/perawatan_dasar_1.jpg', // ← ganti nama file Anda
      'assets/images/perawatan_dasar_2.jpg',
      'assets/images/perawatan_dasar_3.jpg',
    ],
  ),
  'Kesehatan & Keamanan': _PerawatanData(
    kategori: 'Kesehatan & Keamanan',
    emoji: '🏥',
    bgColor: AppColors.iconPinkBg,
    deskripsi:
        'Kesehatan dan keamanan adalah prioritas utama kami. Kami melakukan pemantauan kondisi fisik harian, pengecekan kesehatan dasar, serta pemberian obat jika diperlukan.\n\nDengan sistem pengawasan 24 jam dan kesiapan penanganan darurat, hewanmu selalu dalam kondisi aman dan terjaga.',
    imagePaths: [
      'assets/images/perawatan_kesehatan_1.jpeg',
      'assets/images/perawatan_kesehatan_2.jpeg',
      'assets/images/perawatan_kesehatan_3.jpeg',
    ],
  ),
  'Aktivitas & Kenyamanan': _PerawatanData(
    kategori: 'Aktivitas & Kenyamanan',
    emoji: '🎾',
    bgColor: AppColors.iconOrangeBg,
    deskripsi:
        'Kami menyediakan berbagai aktivitas menyenangkan untuk menjaga kebahagiaan hewan. Mulai dari waktu bermain, jalan-jalan (untuk anjing), hingga stimulasi mental dengan mainan.\n\nDitambah dengan tempat istirahat yang nyaman dan interaksi hangat bersama caregiver, hewanmu akan merasa seperti di rumah sendiri.',
    imagePaths: [
      'assets/images/perawatan_aktivitas_1.jpeg',
      'assets/images/perawatan_aktivitas_2.jpeg',
      'assets/images/perawatan_aktivitas_3.jpeg',
    ],
  ),
  'Perhatian Khusus': _PerawatanData(
    kategori: 'Perhatian Khusus',
    emoji: '💝',
    bgColor: AppColors.cardPurple,
    deskripsi:
        'Setiap hewan memiliki kebutuhan yang unik. Kami memberikan perhatian khusus untuk hewan lansia, hewan yang sedang sakit atau dalam masa pemulihan, serta hewan dengan tingkat kecemasan tertentu.\n\nDengan pengawasan ekstra dan perawatan yang disesuaikan, kami memastikan mereka mendapatkan perhatian terbaik.',
    imagePaths: [
      'assets/images/perawatan_khusus_1.jpeg',
      'assets/images/perawatan_khusus_2.jpeg',
      'assets/images/perawatan_khusus_3.jpeg',
    ],
  ),
};

// Urutan kategori
const List<String> _kategoriUrutan = [
  'Kebutuhan Dasar',
  'Kesehatan & Keamanan',
  'Aktivitas & Kenyamanan',
  'Perhatian Khusus',
];

class PerawatanDetailScreen extends StatefulWidget {
  final String kategori;
  const PerawatanDetailScreen({super.key, required this.kategori});

  @override
  State<PerawatanDetailScreen> createState() => _PerawatanDetailScreenState();
}

class _PerawatanDetailScreenState extends State<PerawatanDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImage = 0;

  // Cari index kategori saat ini
  int get _currentKategoriIndex =>
      _kategoriUrutan.indexOf(widget.kategori);

  // Apakah masih ada kategori berikutnya
  bool get _hasNext =>
      _currentKategoriIndex < _kategoriUrutan.length - 1;

  String? get _nextKategori => _hasNext
      ? _kategoriUrutan[_currentKategoriIndex + 1]
      : null;

  void _goToNext() {
    if (_nextKategori != null) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              PerawatanDetailScreen(kategori: _nextKategori!),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 350),
        ),
      );
    } else {
      // Sudah kategori terakhir, kembali
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = _dataMap[widget.kategori]!;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // ── Top Bar ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: AppColors.textDark),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Perawatan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.kategori,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('🐾', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Image Carousel (3 foto, pakai asset) ─────────────
              Stack(
                children: [
                  SizedBox(
                    height: 240,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) => setState(() => _currentImage = i),
                      itemCount: data.imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              data.imagePaths[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              // Placeholder kalau foto belum ada
                              errorBuilder: (_, __, ___) => Container(
                                decoration: BoxDecoration(
                                  color: data.bgColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(data.emoji,
                                        style: const TextStyle(fontSize: 52)),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Foto ${index + 1}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textGrey,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        data.imagePaths[index]
                                            .split('/')
                                            .last,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: AppColors.textGrey,
                                          fontFamily: 'Nunito',
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

                  // Left arrow
                  if (_currentImage > 0)
                    Positioned(
                      left: 32,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.chevron_left_rounded,
                                color: AppColors.textDark, size: 22),
                          ),
                        ),
                      ),
                    ),

                  // Right arrow
                  if (_currentImage < data.imagePaths.length - 1)
                    Positioned(
                      right: 32,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.chevron_right_rounded,
                                color: AppColors.textDark, size: 22),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // ── Dot Indicator (3 titik) ──────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(data.imagePaths.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentImage == i ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentImage == i
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 28),

              // ── Deskripsi ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  data.deskripsi,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: AppColors.textDark,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // ── Tombol Next Kategori / Selesai ───────────────────
              Center(
                child: GestureDetector(
                  onTap: _goToNext,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.textPurple,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPurple.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _hasNext
                          ? Icons.arrow_forward_rounded
                          : Icons.check_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
