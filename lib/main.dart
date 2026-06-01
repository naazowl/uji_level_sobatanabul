import 'package:flutter/material.dart';

// 💡 IMPORT SCREENS: Pastikan mengimpor file splash dan onboarding kamu
import 'package:app1/screens/splash_screen.dart';
import 'package:app1/screens/onboarding_screen.dart';
import 'package:app1/screens/home_screen.dart';
import 'package:app1/theme/app_theme.dart';

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
      
      // 💡 PERBAIKAN: Ganti HomeScreen() menjadi SplashScreen() sebagai gerbang utama
      home: const SplashScreen(),
    );
  }
}