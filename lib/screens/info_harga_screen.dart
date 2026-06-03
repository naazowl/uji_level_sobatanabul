import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

class InfoHargaScreen extends StatelessWidget {
  final String hewan;
  const InfoHargaScreen({super.key, required this.hewan});

  @override
  Widget build(BuildContext context) {
    final isKucing = hewan == 'Kucing';
    final accentColor = isKucing
        ? const Color(0xFFFF9F43)
        : const Color(0xFF2980B9);
    final bgGradientStart = isKucing
        ? const Color(0xFFFFE5C4)
        : const Color(0xFFD6EFFF);
    final hargaPenitipan = isKucing ? 100000 : 110000;
    final emoji = isKucing ? '🐱' : '🐶';

    final List<Map<String, dynamic>> layanan = isKucing
        ? [
            {'label': 'Kesehatan & keamanan', 'harga': 100000, 'icon': Icons.health_and_safety_rounded, 'color': const Color(0xFF0288D1), 'bg': const Color(0xFFE1F5FE)},
            {'label': 'Aktivitas & kenyamanan', 'harga': 80000, 'icon': Icons.pets_rounded, 'color': const Color(0xFF388E3C), 'bg': const Color(0xFFE8F5E9)},
            {'label': 'Perhatian khusus kondisi hewan', 'harga': 150000, 'icon': Icons.star_rounded, 'color': const Color(0xFFF57C00), 'bg': const Color(0xFFFFF3E0)},
          ]
        : [
            {'label': 'Kesehatan & keamanan', 'harga': 120000, 'icon': Icons.health_and_safety_rounded, 'color': const Color(0xFF0288D1), 'bg': const Color(0xFFE1F5FE)},
            {'label': 'Aktivitas & kenyamanan', 'harga': 100000, 'icon': Icons.pets_rounded, 'color': const Color(0xFF388E3C), 'bg': const Color(0xFFE8F5E9)},
            {'label': 'Perhatian khusus kondisi hewan', 'harga': 200000, 'icon': Icons.star_rounded, 'color': const Color(0xFFF57C00), 'bg': const Color(0xFFFFF3E0)},
          ];

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Stack(
        children: [
          // Background gradasi atas
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bgGradientStart, AppColors.bgLight],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── TOP BAR ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 42, height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10, offset: const Offset(0, 4),
                            )],
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text('Informasi Harga',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                        ),
                      ),
                      const SizedBox(width: 42),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    child: Column(
                      children: [
                        // ── EMOJI + JUDUL ──────────────────────
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(
                              color: accentColor.withOpacity(0.2),
                              blurRadius: 20, offset: const Offset(0, 8),
                            )],
                          ),
                          child: Text(emoji, style: const TextStyle(fontSize: 52)),
                        ),
                        const SizedBox(height: 12),
                        Text('Tarif Penitipan $hewan',
                          style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 20),

                        // ── CARD UTAMA ─────────────────────────
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 24, offset: const Offset(0, 8),
                            )],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hero harga penitipan
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [accentColor, accentColor.withOpacity(0.8)],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text('Biaya Dasar Penitipan',
                                          style: TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600)),
                                        SizedBox(height: 4),
                                        Text('Sudah termasuk kebutuhan dasar',
                                          style: TextStyle(fontSize: 11, color: Colors.white70)),
                                      ],
                                    ),
                                    Text('${_fmtRp(hargaPenitipan)}/Hari',
                                      style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Sudah termasuk
                              _sectionTitle('✅ Sudah Termasuk'),
                              const SizedBox(height: 10),
                              ...[
                                'Pemberian makan & minum sesuai jadwal',
                                'Membersihkan kandang / litter box',
                                'Grooming dasar',
                                'Laporan harian via aplikasi',
                              ].map((item) => _checkItem(item, Colors.green)),

                              const SizedBox(height: 20),

                              // Tidak termasuk
                              _sectionTitle('❌ Tidak Termasuk'),
                              const SizedBox(height: 10),
                              ...[
                                'Kesehatan & keamanan medis ekstra',
                                'Aktivitas bermain & kenyamanan khusus',
                                'Perhatian intensif kondisi khusus',
                              ].map((item) => _checkItem(item, Colors.red, isX: true)),

                              const SizedBox(height: 24),

                              // Detail harga tambahan
                              _sectionTitle('💰 Layanan Tambahan Opsional'),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Expanded(child: _hargaCard(layanan[0])),
                                  const SizedBox(width: 10),
                                  Expanded(child: _hargaCard(layanan[1])),
                                ],
                              ),
                              const SizedBox(height: 10),
                              _hargaCard(layanan[2], fullWidth: true),

                              const SizedBox(height: 20),

                              // Catatan
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF9E6),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFFFFEAA7), width: 1.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: const [
                                      Icon(Icons.calculate_rounded, color: Color(0xFFD35400), size: 18),
                                      SizedBox(width: 8),
                                      Text('Sistem Kelipatan Biaya',
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFD35400))),
                                    ]),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '• Harga dikalikan jumlah hari penitipan\n• Kebutuhan dasar sudah termasuk biaya pokok\n• Pembayaran dilakukan saat check-in',
                                      style: TextStyle(fontSize: 12, color: Color(0xFF5E6A75), height: 1.5)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Tombol kembali
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [BoxShadow(
                                color: accentColor.withOpacity(0.35),
                                blurRadius: 12, offset: const Offset(0, 4),
                              )],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Paham, Kembali',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(text,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900));

  Widget _checkItem(String text, Color color, {bool isX = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 1),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isX ? Icons.close_rounded : Icons.check_rounded,
              size: 12, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF555555), height: 1.4))),
        ],
      ),
    );
  }

  Widget _hargaCard(Map<String, dynamic> data, {bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: data['bg'] as Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(data['icon'] as IconData, color: data['color'] as Color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['label'] as String,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(_fmtRp(data['harga'] as int),
                  style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w900,
                    color: data['color'] as Color)),
                Text('/hari', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _fmtRp(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${buf.toString()}';
  }
}