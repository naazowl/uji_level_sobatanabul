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
          physics: const BouncingScrollPhysics(),
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
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16, color: AppColors.textDark),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Informasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                      letterSpacing: -0.5,
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
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Layanan yang kami berikan 🐾',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textDark.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 20),

              _PerawatanCard(
                emoji: '🍽️',
                title: 'Kebutuhan Dasar',
                subtitle: 'Makan, minum & kebersihan harian',
                bgColor: AppColors.iconBlueBg,
                accentColor: Colors.blue.shade700,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Kebutuhan Dasar'))),
              ),
              const SizedBox(height: 14),
              _PerawatanCard(
                emoji: '🏥',
                title: 'Kesehatan & Keamanan',
                subtitle: 'Pemantauan & penanganan darurat',
                bgColor: AppColors.iconPinkBg,
                accentColor: Colors.pink.shade700,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Kesehatan & Keamanan'))),
              ),
              const SizedBox(height: 14),
              _PerawatanCard(
                emoji: '🎾',
                title: 'Aktivitas & Kenyamanan',
                subtitle: 'Bermain, jalan-jalan & stimulasi mental',
                bgColor: AppColors.iconOrangeBg,
                accentColor: Colors.orange.shade800,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PerawatanDetailScreen(kategori: 'Aktivitas & Kenyamanan'))),
              ),
              const SizedBox(height: 14),
              _PerawatanCard(
                emoji: '💝',
                title: 'Perhatian Khusus',
                subtitle: 'Hewan lansia, sakit & kecemasan tinggi',
                bgColor: AppColors.cardPurple,
                accentColor: Colors.purple.shade700,
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
                  letterSpacing: -0.3,
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
                  'Laporan harian via aplikasi',
                ],
                tidakTermasuk: const [
                  'Kesehatan & keamanan',
                  'Aktivitas & kenyamanan',
                  'Perhatian khusus sesuai kondisi hewan',
                ],
                bgColor: AppColors.iconOrangeBg.withOpacity(0.45),
                accentColor: AppColors.primary,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const InfoHargaScreen(hewan: 'Kucing'))),
              ),
              const SizedBox(height: 16),
              _HargaCard(
                icon: '🐶',
                hewan: 'Anjing',
                harga: 'Rp 110.000',
                includes: const [
                  'Makan & minum harian',
                  'Kebersihan kandang',
                  'Laporan harian via aplikasi',
                ],
                tidakTermasuk: const [
                  'Kesehatan & keamanan',
                  'Aktivitas & kenyamanan',
                  'Perhatian khusus sesuai kondisi hewan',
                ],
                bgColor: AppColors.petCardBg.withOpacity(0.55),
                accentColor: const Color(0xFF2B7BB9),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const InfoHargaScreen(hewan: 'Anjing'))),
              ),

              const SizedBox(height: 36),

              // ── Section: Tim Pengasuh ───────────────────────────
              const Text(
                'Tim Pengasuh',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  fontFamily: 'Nunito',
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                child: const _PreviewPengasuhCard(
                  imagePath: 'assets/images/pengasuh_shinta.jpeg',
                  nama: 'Kak Shinta (24 Tahun)',
                  jabatan: 'Cat Whisperer & Nutritionist',
                  bgColor: Color(0xFFFDF0E6),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                child: const _PreviewPengasuhCard(
                  imagePath: 'assets/images/pengasuh_tiara.jpeg',
                  nama: 'Kak Tiara (22 Tahun)',
                  jabatan: 'Playtime Coordinator & Socialization Expert',
                  bgColor: Color(0xFFF3EAFB),
                ),
              ),
              const SizedBox(height: 14),
              
              // Tombol lihat semua pengasuh dengan InkWell
              Material(
                color: AppColors.textPurple.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PengasuhScreen())),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.textPurple.withOpacity(0.15)),
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
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 16),

              _PreviewFasilitasCard(
                icon: '🛏️',
                nama: 'Tempat Tidur Khusus',
                deskripsi: '10 tempat tidur kucing & 10 untuk anjing',
                bgColor: const Color(0xFFF5F0FC),
                accentColor: const Color(0xFF6747A6),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FasilitasScreen())),
              ),
              const SizedBox(height: 12),
              _PreviewFasilitasCard(
                icon: '🎾',
                nama: 'Tempat Bermain',
                deskripsi: 'Ruang bermain terpisah untuk kucing & anjing',
                bgColor: const Color(0xFFFBF7E3),
                accentColor: const Color(0xFF9E7A15),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FasilitasScreen())),
              ),
              const SizedBox(height: 14),
              
              // Tombol lihat semua fasilitas dengan InkWell
              Material(
                color: const Color(0xFF7C5CBF).withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FasilitasScreen())),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF7C5CBF).withOpacity(0.15)),
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
  final Color accentColor;
  final VoidCallback onTap;

  const _PerawatanCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textDark.withOpacity(0.65),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 12, color: accentColor),
                ),
              ],
            ),
          ),
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
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris Atas
                Row(
                  children: [
                    Text(icon, style: const TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        hewan,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        harga,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Divider(color: AppColors.textDark.withOpacity(0.08), thickness: 1.5),
                const SizedBox(height: 14),

                // Sudah Termasuk
                Text(
                  'Sudah termasuk:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: accentColor,
                    fontFamily: 'Nunito',
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                ...includes.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_rounded, size: 15, color: accentColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textDark,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 14),

                // Tidak Termasuk
                const Text(
                  'Tidak termasuk:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textGrey,
                    fontFamily: 'Nunito',
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                ...tidakTermasuk.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.remove_circle_outline_rounded,
                          size: 15, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textDark.withOpacity(0.6),
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 16),
                
                // Footer Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Lihat detail harga',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: accentColor,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios_rounded, size: 10, color: accentColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Widget: Preview Pengasuh Card ───────────────────────────────────────────
class _PreviewPengasuhCard extends StatelessWidget {
  final String imagePath;
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
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              imagePath,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(14),
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
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  jabatan,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textDark.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
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
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                      const SizedBox(height: 4),
                      Text(
                        deskripsi,
                        style: TextStyle(
                          fontSize: 12,
                          color: accentColor,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}