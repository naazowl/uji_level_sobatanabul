import 'package:flutter/material.dart';
import 'package:app1/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Menggunakan kurva animasi yang lebih halus dan membal (elastic/back)
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // Pindah ke onboarding setelah 3 detik untuk memberikan waktu transisi yang cukup
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const OnboardingScreen(),
            transitionsBuilder: (_, anim, _, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF2B7BB9);

    return Scaffold(
      body: Container(
        // 1. Menggunakan gradasi linear untuk latar belakang yang estetik
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFD6EFFA),
              Color(0xFFB3E5FC),
            ],
          ),
        ),
        child: Stack(
          children: [
            // 2. Elemen Dekorasi Background agar tidak terlalu sepi
            Positioned(
              top: -60,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.25),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              right: -40,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryBlue.withValues(alpha: 0.06),
                ),
              ),
            ),

            // 3. Konten Utama di Tengah Layar
            Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Desain Wadah Ikon Paw Premium
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryBlue.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF3D5A80).withValues(alpha: 0.1),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.pets,
                            size: 48,
                            color: Color(0xFF3D5A80),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Nama Aplikasi (SobatAnabul)
                      Text(
                        'SobatAnabul',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: primaryBlue,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      // Slogan / Subtitle Aplikasi
                      Text(
                        'Titip & Rawat dengan Hati',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: primaryBlue.withValues(alpha: 0.65),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. Loading Indikator Halus di Bagian Bawah Layar
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      primaryBlue.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}