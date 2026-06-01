import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

// Ganti isi file: lib/widgets/quick_action_button.dart
// Tambahkan parameter onTap agar bisa navigate ke screen lain

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback? onTap; // ← parameter baru (opsional, tidak wajib diisi)

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.onTap, // ← opsional, tombol lain tidak perlu diubah
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ← connect ke fungsi navigate
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 28, color: AppColors.textDark),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}
