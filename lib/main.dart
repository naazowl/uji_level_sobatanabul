import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

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
      home: const HomeScreen(),
    );
  }
}
