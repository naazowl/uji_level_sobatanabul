import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF8C42);
  static const Color secondary = Color(0xFFB8A9F8);
  static const Color bgLight = Color(0xFFF8F7F4);

  static const Color iconBlueBg = Color(0xFFBDE3F5);
  static const Color iconOrangeBg = Color(0xFFFFDDA8);
  static const Color iconPinkBg = Color(0xFFFFB8C1);
  static const Color iconYellowBg = Color(0xFFEEF58A);

  static const Color cardPurple = Color(0xFFD5CCFA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF9E9E9E);
  static const Color textPurple = Color(0xFF6C4FBF);
  static const Color petCardBg = Color(0xFFDBEFF8);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgLight,
      fontFamily: 'Nunito',
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
    );
  }
}
