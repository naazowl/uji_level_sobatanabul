import 'package:flutter/material.dart';

class DailyReportBanner extends StatelessWidget {
  const DailyReportBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFD5CCFA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Laporan Harian',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5C3DBF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'SobatAnabul',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5C3DBF).withOpacity(0.6),
                ),
              ),
            ],
          ),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8C42).withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pets,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
