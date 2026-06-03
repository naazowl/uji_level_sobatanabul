import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

// Kumpulan Import Screens
import 'package:app1/screens/splash_screen.dart';
import 'package:app1/screens/onboarding_screen.dart';
import 'package:app1/screens/login_screen.dart';       // Tambahkan ini jika belum ada
import 'package:app1/screens/register_screen.dart';    // Tambahkan ini jika belum ada
import 'package:app1/screens/home_screen.dart';

void main() {
  runApp(const SobatAnabulApp());
}

class SobatAnabulApp extends StatelessWidget {
  const SobatAnabulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SobatAnabul',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // Gerbang utama dimulai dari SplashScreen
      home: const SplashScreen(),
    );
  }
}