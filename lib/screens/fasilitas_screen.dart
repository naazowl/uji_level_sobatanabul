import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

class _Fasilitas {
  final String nama;
  final String deskripsi;
  final String imagePath; // ganti dengan path foto Anda
  final Color bgColor;
  final Color accentColor;
  final String icon;

  const _Fasilitas({
    required this.nama,
    required this.deskripsi,
    required this.imagePath,
    required this.bgColor,
    required this.accentColor,
    required this.icon,
  });
}

const List<_Fasilitas> _daftarFasilitas = [
  _Fasilitas(
    nama: 'Tempat Tidur Khusus',
    icon: '🛏️',
    imagePath: 'assets/images/fasilitas_tidur_khusus.webp',
    bgColor: Color(0xFFF0EBF8),
    accentColor: Color(0xFF7C5CBF),
    deskripsi:
        'Pet care kami menyediakan fasilitas nyaman dengan 10 tempat tidur untuk kucing dan 10 tempat tidur untuk anjing. Setiap ruang dirancang bersih, aman, dan dilengkapi alas yang empuk, serta dipantau oleh staf berpengalaman agar hewan peliharaan tetap nyaman selama menginap.',
  ),
  _Fasilitas(
    nama: 'Tempat Tidur',
    icon: '😴',
    imagePath: 'assets/images/fasilitas_tidur.webp',
    bgColor: Color(0xFFFDE8D8),
    accentColor: Color(0xFFE8773A),
    deskripsi:
        'Pet care kami menyediakan fasilitas khusus untuk hewan tua, sakit, atau berkebutuhan khusus. Tersedia 5 tempat tidur untuk kucing di area tenang dengan pemantauan ekstra, serta 5 tempat tidur untuk anjing dengan ruang nyaman dan perawatan intensif untuk mendukung pemulihan.',
  ),
  _Fasilitas(
    nama: 'Tempat Mandi',
    icon: '🛁',
    imagePath: 'assets/images/fasilitas_mandi.webp',
    bgColor: Color(0xFFD8EDF5),
    accentColor: Color(0xFF3A8EBF),
    deskripsi:
        'Tersedia 1 tempat mandi untuk kucing dan 1 tempat mandi untuk anjing, dirancang terpisah agar lebih nyaman, aman, dan higienis selama proses perawatan.',
  ),
  _Fasilitas(
    nama: 'Ruangan Perawatan',
    icon: '🏥',
    imagePath: 'assets/images/fasilitas_perawatan.webp',
    bgColor: Color(0xFFD8F5E8),
    accentColor: Color(0xFF2E9E6B),
    deskripsi:
        'Tersedia 1 ruang perawatan dan cek kesehatan yang nyaman dan higienis untuk memastikan kondisi hewan tetap terpantau dengan baik.',
  ),
  _Fasilitas(
    nama: 'Tempat Bermain',
    icon: '🎾',
    imagePath: 'assets/images/fasilitas_bermain.jpeg',
    bgColor: Color(0xFFFAF3D8),
    accentColor: Color(0xFFBF9A2E),
    deskripsi:
        'Tersedia 1 ruang bermain untuk anjing dan 1 ruang bermain untuk kucing, dirancang terpisah agar hewan dapat beraktivitas dengan aman dan nyaman.',
  ),
  _Fasilitas(
    nama: 'Tempat Makan & Minum',
    icon: '🍽️',
    imagePath: 'assets/images/fasilitas_makan.jpeg',
    bgColor: Color(0xFFFFEBEB),
    accentColor: Color(0xFFBF3A3A),
    deskripsi:
        'Tersedia 30 pasang tempat makan dan minum berbahan stainless steel yang higienis, tahan lama, dan mudah dibersihkan untuk menjaga kesehatan hewan peliharaan.',
  ),
];

class FasilitasScreen extends StatefulWidget {
  const FasilitasScreen({super.key});

  @override
  State<FasilitasScreen> createState() => _FasilitasScreenState();
}

class _FasilitasScreenState extends State<FasilitasScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex < _daftarFasilitas.length - 1) {
      setState(() => _currentIndex++);
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void _goPrev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = _daftarFasilitas[_currentIndex];

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
                    'Fasilitas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  // Counter
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: f.accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1}/${_daftarFasilitas.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: f.accentColor,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── PageView Kartu Fasilitas ─────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                itemCount: _daftarFasilitas.length,
                itemBuilder: (context, index) {
                  final fasilitas = _daftarFasilitas[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _FasilitasCard(fasilitas: fasilitas),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ── Dot Indicator ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _daftarFasilitas.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == i ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: _currentIndex == i
                        ? f.accentColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Tombol Navigasi ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
              child: Row(
                children: [
                  // Sebelumnya
                  Expanded(
                    child: GestureDetector(
                      onTap: _goPrev,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 52,
                        decoration: BoxDecoration(
                          color: _currentIndex > 0
                              ? Colors.white
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _currentIndex > 0
                                ? Colors.grey.shade200
                                : Colors.grey.shade100,
                          ),
                          boxShadow: _currentIndex > 0
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
                            Icon(Icons.arrow_back_rounded,
                                size: 18,
                                color: _currentIndex > 0
                                    ? AppColors.textDark
                                    : Colors.grey.shade400),
                            const SizedBox(width: 6),
                            Text(
                              'Sebelumnya',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                color: _currentIndex > 0
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

                  // Selanjutnya
                  Expanded(
                    child: GestureDetector(
                      onTap: _goNext,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 52,
                        decoration: BoxDecoration(
                          color: _currentIndex < _daftarFasilitas.length - 1
                              ? f.accentColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow:
                              _currentIndex < _daftarFasilitas.length - 1
                                  ? [
                                      BoxShadow(
                                        color: f.accentColor.withOpacity(0.35),
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
                                color: _currentIndex <
                                        _daftarFasilitas.length - 1
                                    ? Colors.white
                                    : Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded,
                                size: 18,
                                color: _currentIndex <
                                        _daftarFasilitas.length - 1
                                    ? Colors.white
                                    : Colors.grey.shade400),
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

// ── Widget: Kartu Fasilitas ───────────────────────────────────────────────────
class _FasilitasCard extends StatelessWidget {
  final _Fasilitas fasilitas;

  const _FasilitasCard({required this.fasilitas});

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
          // ── Foto Fasilitas ─────────────────────────────────────
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Foto dari assets lokal
                Image.asset(
                  fasilitas.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: fasilitas.bgColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(fasilitas.icon,
                            style: const TextStyle(fontSize: 64)),
                        const SizedBox(height: 12),
                        Text(
                          'Tambahkan foto\n${fasilitas.nama}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: fasilitas.accentColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'assets/images/${fasilitas.imagePath.split('/').last}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: fasilitas.accentColor.withOpacity(0.6),
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
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Nama fasilitas overlay (bottom-left)
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Text(
                    fasilitas.nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),

                // Badge icon (top-right)
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: fasilitas.accentColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: fasilitas.accentColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(fasilitas.icon,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Deskripsi ──────────────────────────────────────────
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: fasilitas.bgColor.withOpacity(0.4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: fasilitas.accentColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tentang Fasilitas',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: fasilitas.accentColor,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        fasilitas.deskripsi,
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
