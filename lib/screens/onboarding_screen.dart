import 'package:flutter/material.dart';
import 'package:app1/screens/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Palet Warna Aplikasi Modern SobatAnabul
  final Color _primaryBlue = const Color(0xFF2B7BB9);
  final Color _activeDotOrange = const Color(0xFFFF8441); // Oranye hangat untuk dot aktif

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'SobatAnabul',
      subtitle: 'Titipkan hewan peliharaanmu\ndengan aman dan nyaman!',
      imagePath: 'assets/images/kucing_anjing.png',
      bgColor: Color(0xFFD6EFFA),
    ),
    _OnboardingData(
      title: 'Pantau Kapan Saja',
      subtitle: 'Dapatkan laporan harian\npeliharaanmu secara real-time.',
      imagePath: 'assets/images/anjing.png',
      bgColor: Color(0xFFE8F5E9),
    ),
    _OnboardingData(
      title: 'Perawatan Terbaik',
      subtitle: 'Anabulmu dirawat oleh\ntenaga berpengalaman.',
      imagePath: 'assets/images/kucing.png',
      bgColor: Color(0xFFFFF3E0),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

    void _goToHome() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
  );
}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: page.bgColor,
        child: SafeArea(
          child: Column(
            children: [
              // Bagian Atas: Tombol Lewati
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 24),
                  child: _currentPage < _pages.length - 1
                      ? TextButton(
                          onPressed: _goToHome,
                          style: TextButton.styleFrom(
                            foregroundColor: _primaryBlue.withValues(alpha: 0.7),
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Lewati'),
                        )
                      : const SizedBox(height: 48),
                ),
              ),

              // Bagian Tengah: PageView Gambar & Teks Konten
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (_, index) => _OnboardingPage(
                    data: _pages[index], 
                    primaryColor: _primaryBlue,
                  ),
                ),
              ),

              // Bagian Bawah: Indikator & Tombol Putih Kontras
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indikator Titik (Dots) Halaman aktif
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? _activeDotOrange
                                : _primaryBlue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Tombol Aksi Utama: Latar Belakang Putih & Tulisan Biru Tua
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Mengubah tombol menjadi putih
                        foregroundColor: _primaryBlue, // Mengubah warna teks menjadi biru tua
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 4, // Sedikit dinaikkan agar tombol putih menonjol dari latar pastel
                        shadowColor: Colors.black.withValues(alpha: 0.08),
                      ),
                      child: Text(
                        _currentPage < _pages.length - 1 ? 'Lanjut' : 'Mulai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800, // Membuat teks lebih tegas & premium
                          color: _primaryBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  final Color primaryColor;
  
  const _OnboardingPage({required this.data, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ilustrasi Gambar Utama dengan Efek Lingkaran Lembut
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  data.imagePath,
                  width: 260,
                  height: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.pets,
                    size: 120,
                    color: primaryColor.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),

          // Judul Halaman
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: primaryColor,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 14),

          // Sub-judul / Deskripsi
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: primaryColor.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color bgColor;

  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.bgColor,
  });
}