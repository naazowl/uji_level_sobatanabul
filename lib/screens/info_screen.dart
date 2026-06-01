import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';
import 'package:app1/screens/perawatan_detail_screen.dart';
import 'package:app1/screens/pengasuh_screen.dart';
import 'package:app1/screens/fasilitas_screen.dart';
import 'package:app1/screens/info_harga_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // ── Top Bar ──────────────────────────────────────────
              Row(
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
                  const Text(
                    'Informasi',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Section: Perawatan ───────────────────────────────
              const Text(
                'Perawatan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Layanan yang kami berikan 🐾',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 20),

              _PerawatanCard(
                emoji: '🍽️',
                title: 'Kebutuhan Dasar',
                subtitle: 'Makan, minum & kebersihan harian',
                bgColor: AppColors.iconBlueBg,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Kebutuhan Dasar'))),
              ),
              const SizedBox(height: 12),
              _PerawatanCard(
                emoji: '🏥',
                title: 'Kesehatan & Keamanan',
                subtitle: 'Pemantauan & penanganan darurat',
                bgColor: AppColors.iconPinkBg,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Kesehatan & Keamanan'))),
              ),
              const SizedBox(height: 12),
              _PerawatanCard(
                emoji: '🎾',
                title: 'Aktivitas & Kenyamanan',
                subtitle: 'Bermain, jalan-jalan & stimulasi mental',
                bgColor: AppColors.iconOrangeBg,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Aktivitas & Kenyamanan'))),
              ),
              const SizedBox(height: 12),
              _PerawatanCard(
                emoji: '💝',
                title: 'Perhatian Khusus',
                subtitle: 'Hewan lansia, sakit & kecemasan tinggi',
                bgColor: AppColors.cardPurple,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Perhatian Khusus'))),
              ),

              const SizedBox(height: 36),

              // ── Section: Harga ───────────────────────────────────
              const Text(
                'Harga Per-Hari',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 16),

              _HargaCard(
                icon: '🐱',
                hewan: 'Kucing',
                harga: 'Rp 100.000',
                includes: const [
                  'Makan & minum harian',
                  'Kebersihan kandang',
                  'Pemantauan kesehatan dasar',
                  'Laporan harian via aplikasi',
                ],
                tidakTermasuk: const [
                  'Kesehatan & keamanan',
                  'Aktivitas & kenyamanan',
                  'Perhatian khusus sesuai kondisi hewan',
                ],
                bgColor: AppColors.iconOrangeBg,
                accentColor: AppColors.primary,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const InfoHargaScreen(hewan: 'Kucing'))),
              ),
              const SizedBox(height: 12),
              _HargaCard(
                icon: '🐶',
                hewan: 'Anjing',
                harga: 'Rp 110.000',
                includes: const [
                  'Makan & minum harian',
                  'Kebersihan kandang',
                  'Pemantauan kesehatan dasar',
                  'Laporan harian via aplikasi',
                ],
                tidakTermasuk: const [
                  'Kesehatan & keamanan',
                  'Aktivitas & kenyamanan',
                  'Perhatian khusus sesuai kondisi hewan',
                ],
                bgColor: AppColors.petCardBg,
                accentColor: const Color(0xFF3A8EBF),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const InfoHargaScreen(hewan: 'Anjing'))),
              ),

              const SizedBox(height: 36),

              // ── Section: Tim Pengasuh → navigate ke PengasuhScreen
              const Text(
                'Tim Pengasuh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 16),

              // Preview 2 pengasuh — tap → PengasuhScreen
              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                child: _PreviewPengasuhCard(
                  imagePath: 'assets/images/pengasuh_shinta.jpg',
                  nama: 'Kak Shinta (24 Tahun)',
                  jabatan: 'Cat Whisperer & Nutritionist',
                  bgColor: const Color(0xFFFDE8D8),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                child: _PreviewPengasuhCard(
                  imagePath: 'assets/images/pengasuh_tiara.jpg',
                  nama: 'Kak Tiara (22 Tahun)',
                  jabatan: 'Playtime Coordinator & Socialization Expert',
                  bgColor: const Color(0xFFE8D8F5),
                ),
              ),
              const SizedBox(height: 10),
              // Tombol lihat semua pengasuh
              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.textPurple.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.textPurple.withOpacity(0.2)),
                  ),
                  child: const Center(
                    child: Text(
                      'Lihat Semua Pengasuh (6 orang) →',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPurple,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // ── Section: Fasilitas ───────────────────────────────
              const Text(
                'Fasilitas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 16),

              // Preview 2 fasilitas
              _PreviewFasilitasCard(
                icon: '🛏️',
                nama: 'Tempat Tidur Khusus',
                deskripsi: '10 tempat tidur kucing & 10 untuk anjing',
                bgColor: const Color(0xFFF0EBF8),
                accentColor: const Color(0xFF7C5CBF),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const FasilitasScreen())),
              ),
              const SizedBox(height: 10),
              _PreviewFasilitasCard(
                icon: '🎾',
                nama: 'Tempat Bermain',
                deskripsi: 'Ruang bermain terpisah untuk kucing & anjing',
                bgColor: const Color(0xFFFAF3D8),
                accentColor: const Color(0xFFBF9A2E),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FasilitasScreen())),
              ),
              const SizedBox(height: 10),
              // Tombol lihat semua fasilitas
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FasilitasScreen())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C5CBF).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF7C5CBF).withOpacity(0.2)),
                  ),
                  child: const Center(
                    child: Text(
                      'Lihat Semua Fasilitas (6 fasilitas) →',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7C5CBF),
                        fontFamily: 'Nunito',
                      ),
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

// ── Widget: Perawatan Card ────────────────────────────────────────────────────
class _PerawatanCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;
  final VoidCallback onTap;

  const _PerawatanCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColors.textDark),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget: Harga Card ────────────────────────────────────────────────────────
class _HargaCard extends StatelessWidget {
  final String icon;
  final String hewan;
  final String harga;
  final List<String> includes;
  final List<String> tidakTermasuk;
  final Color bgColor;
  final Color accentColor;
  final VoidCallback? onTap;

  const _HargaCard({
    required this.icon,
    required this.hewan,
    required this.harga,
    required this.includes,
    required this.tidakTermasuk,
    required this.bgColor,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Baris atas: icon + nama + harga badge ──
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 38)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(hewan,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(harga,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: accentColor.withOpacity(0.2), thickness: 1),
            const SizedBox(height: 10),

            // ── Sudah termasuk ──────────────────────────
            Text('Sudah termasuk:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: accentColor,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 6),
            ...includes.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded,
                      size: 14, color: accentColor),
                  const SizedBox(width: 6),
                  Text(item,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )),

            const SizedBox(height: 10),

            // ── Tidak termasuk ──────────────────────────
            Text('Tidak termasuk:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textGrey,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 6),
            ...tidakTermasuk.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.remove_circle_outline_rounded,
                      size: 14, color: Colors.grey.shade400),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(item,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            )),

            const SizedBox(height: 12),

            // ── Tap untuk detail ────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Lihat detail harga',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 11, color: accentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget: Preview Pengasuh Card (di info_screen) ───────────────────────────
class _PreviewPengasuhCard extends StatelessWidget {
  final String imagePath; // ← pakai asset foto
  final String nama;
  final String jabatan;
  final Color bgColor;

  const _PreviewPengasuhCard({
    required this.imagePath,
    required this.nama,
    required this.jabatan,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Foto profil
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_rounded,
                    size: 28, color: AppColors.textPurple),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 2),
                Text(jabatan,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: AppColors.textGrey),
        ],
      ),
    );
  }
}

// ── Widget: Preview Fasilitas Card ───────────────────────────────────────────
class _PreviewFasilitasCard extends StatelessWidget {
  final String icon;
  final String nama;
  final String deskripsi;
  final Color bgColor;
  final Color accentColor;
  final VoidCallback onTap;

  const _PreviewFasilitasCard({
    required this.icon,
    required this.nama,
    required this.deskripsi,
    required this.bgColor,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    deskripsi,
                    style: TextStyle(
                      fontSize: 12,
                      color: accentColor,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
