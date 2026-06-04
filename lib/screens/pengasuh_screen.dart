import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

class _Pengasuh {
  final String nama;
  final int umur;
  final String jabatan;
  final String keahlian;
  final String fotoPath;
  final Color bgColor;
  final Color accentColor;

  const _Pengasuh({
    required this.nama,
    required this.umur,
    required this.jabatan,
    required this.keahlian,
    required this.fotoPath,
    required this.bgColor,
    required this.accentColor,
  });
}

const List<_Pengasuh> _daftarPengasuh = [
  _Pengasuh(
    nama: 'Kak Shinta',
    umur: 24,
    jabatan: 'Cat Whisperer & Nutritionist',
    keahlian: 'Memiliki kedekatan alami dengan kucing. Ia sangat paham mengenai kebutuhan diet khusus kucing dan ahli dalam menangani kucing yang sedang stres atau sulit beradaptasi di lingkungan baru.',
    fotoPath: 'assets/images/pengasuh_shinta.jpeg',
    bgColor: Color(0xFFFDE8D8),
    accentColor: Color(0xFFE8773A),
  ),
  _Pengasuh(
    nama: 'Kak Tiara',
    umur: 22,
    jabatan: 'Playtime Coordinator & Socialization Expert',
    keahlian: 'Bertanggung jawab mengatur jadwal bermain kelompok agar hewan peliharaan bisa bersosialisasi dengan aman. Ia sangat sabar dan kreatif dalam menciptakan permainan yang melatih ketangkasan anak bulu.',
    fotoPath: 'assets/images/pengasuh_tiara.jpeg',
    bgColor: Color(0xFFEDE8FD),
    accentColor: Color(0xFF7C5CBF),
  ),
  _Pengasuh(
    nama: 'Kak Maya',
    umur: 25,
    jabatan: 'Night Care & Emergency Responder',
    keahlian: 'Spesialis penjagaan malam yang sangat waspada. Ia memiliki sertifikasi pertolongan pertama (First Aid) untuk hewan peliharaan dan memastikan suasana ruang inap tetap tenang serta nyaman.',
    fotoPath: 'assets/images/pengasuh_maya.jpeg',
    bgColor: Color(0xFFD8EDF5),
    accentColor: Color(0xFF3A8EBF),
  ),
  _Pengasuh(
    nama: 'Kak Reza',
    umur: 30,
    jabatan: 'Senior Medical Caretaker',
    keahlian: 'Memiliki latar belakang pendidikan paramedis hewan. Fokus utamanya adalah memantau kesehatan harian, memberikan obat tepat waktu, dan melakukan pengecekan suhu serta kondisi fisik rutin.',
    fotoPath: 'assets/images/pengasuh_reza.jpeg',
    bgColor: Color(0xFFD8F5E8),
    accentColor: Color(0xFF2E9E6B),
  ),
  _Pengasuh(
    nama: 'Kak Dimas',
    umur: 26,
    jabatan: 'Professional Pet Groomer',
    keahlian: 'Ahli dalam perawatan estetika dan kebersihan hewan. Selain menjaga hewan tetap bersih, Dimas juga jeli melihat masalah kulit atau kutu sejak dini agar bisa segera ditangani.',
    fotoPath: 'assets/images/pengasuh_dimas.jpeg',
    bgColor: Color(0xFFFAF3D8),
    accentColor: Color(0xFFBF9A2E),
  ),
  _Pengasuh(
    nama: 'Kak Aris',
    umur: 28,
    jabatan: 'Specialist Dog Handler & Trainer',
    keahlian: 'Berpengalaman dalam menangani berbagai jenis ras anjing, mulai dari yang berenergi tinggi hingga yang pemalu. Ahli teknik basic training dan memastikan anjing tetap aktif melalui aktivitas fisik terukur.',
    fotoPath: 'assets/images/pengasuh_aris.jpeg',
    bgColor: Color(0xFFD8E8F5),
    accentColor: Color(0xFF3A5FBF),
  ),
];

class PengasuhScreen extends StatefulWidget {
  const PengasuhScreen({super.key});

  @override
  State<PengasuhScreen> createState() => _PengasuhScreenState();
}

class _PengasuhScreenState extends State<PengasuhScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_selectedIndex < _daftarPengasuh.length - 1) {
      setState(() => _selectedIndex++);
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void _goPrev() {
    if (_selectedIndex > 0) {
      setState(() => _selectedIndex--);
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = _daftarPengasuh[_selectedIndex];

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── Top Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 16, color: AppColors.textDark),
                    ),
                  ),
                  const Text(
                    'Pengasuh',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  // Counter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_selectedIndex + 1}/${_daftarPengasuh.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPurple,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Main Card (PageView) ─────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _selectedIndex = i),
                itemCount: _daftarPengasuh.length,
                itemBuilder: (context, index) {
                  final pg = _daftarPengasuh[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _PengasuhCard(pengasuh: pg),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ── Dot Indicator ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _daftarPengasuh.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _selectedIndex == i ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _selectedIndex == i
                        ? p.accentColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Navigasi Prev / Next ─────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
              child: Row(
                children: [
                  // Prev
                  Expanded(
                    child: GestureDetector(
                      onTap: _goPrev,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 52,
                        decoration: BoxDecoration(
                          color: _selectedIndex > 0
                              ? Colors.white
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _selectedIndex > 0
                                ? Colors.grey.shade200
                                : Colors.grey.shade100,
                          ),
                          boxShadow: _selectedIndex > 0
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              size: 18,
                              color: _selectedIndex > 0
                                  ? AppColors.textDark
                                  : Colors.grey.shade400,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Sebelumnya',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: _selectedIndex > 0
                                    ? AppColors.textDark
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Next
                  Expanded(
                    child: GestureDetector(
                      onTap: _goNext,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 52,
                        decoration: BoxDecoration(
                          color: _selectedIndex < _daftarPengasuh.length - 1
                              ? p.accentColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _selectedIndex < _daftarPengasuh.length - 1
                              ? [
                                  BoxShadow(
                                    color: p.accentColor.withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Selanjutnya',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: _selectedIndex < _daftarPengasuh.length - 1
                                    ? Colors.white
                                    : Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: _selectedIndex < _daftarPengasuh.length - 1
                                  ? Colors.white
                                  : Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Widget: Kartu Pengasuh ────────────────────────────────────────────────────
class _PengasuhCard extends StatelessWidget {
  final _Pengasuh pengasuh;

  const _PengasuhCard({required this.pengasuh});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // ── Bagian atas: foto full width ───────────────────────
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Foto dari assets lokal
                Image.asset(
                  pengasuh.fotoPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: pengasuh.bgColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_rounded,
                            size: 80, color: pengasuh.accentColor.withOpacity(0.4)),
                        const SizedBox(height: 8),
                        Text(
                          pengasuh.fotoPath.split('/').last,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: pengasuh.accentColor.withOpacity(0.6),
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Gradient overlay bawah
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Nama & umur di atas foto (bottom-left)
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pengasuh.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      Text(
                        '${pengasuh.umur} Tahun',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.85),
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Badge jabatan (top-right)
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: pengasuh.accentColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: pengasuh.accentColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      pengasuh.jabatan.split(' ').take(2).join(' '),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bagian bawah: deskripsi ────────────────────────────
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: pengasuh.bgColor.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Jabatan lengkap
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: pengasuh.accentColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pengasuh.jabatan,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: pengasuh.accentColor,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Keahlian
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        pengasuh.keahlian,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          color: AppColors.textDark.withOpacity(0.7),
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
