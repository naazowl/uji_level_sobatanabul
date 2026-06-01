import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';
import 'package:app1/screens/chat_screen.dart'; // ← tambah import

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? _defaultOnTap(context), // ← fallback jika onTap null
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

  // ← jika label 'Chat' dan onTap null, otomatis navigate ke ChatScreen
  VoidCallback? _defaultOnTap(BuildContext context) {
    if (label == 'Chat') {
      return () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChatScreen(messages: [])),
      );
    }
    return null;
  }
}