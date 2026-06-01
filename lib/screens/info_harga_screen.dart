import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart';

class InfoHargaScreen extends StatelessWidget {
  final String hewan; // 'Kucing' atau 'Anjing'
  const InfoHargaScreen({super.key, required this.hewan});

  @override
  Widget build(BuildContext context) {
    final isKucing = hewan == 'Kucing';

    // ── Data sesuai Figma ──────────────────────────────────────
    final hargaPenitipan = isKucing ? 'Rp 100.000' : 'Rp 110.000';
    final List<String> tidakTermasuk = const [
      'Kesehatan & keamanan',
      'Aktivitas & kenyamanan',
      'Perhatian khusus sesuai kondisi hewan',
    ];
    final List<Map<String, String>> detailHarga = isKucing
        ? [
            {'label': 'Kesehatan & keamanan', 'harga': 'Rp 100.000'},
            {'label': 'Aktivitas & kenyamanan', 'harga': 'Rp 80.000'},
            {'label': 'Perhatian khusus sesuai kondisi hewan', 'harga': 'Rp 150.000'},
          ]
        : [
            {'label': 'Kesehatan & keamanan', 'harga': 'Rp 120.000'},
            {'label': 'Aktivitas & kenyamanan', 'harga': 'Rp 100.000'},
            {'label': 'Perhatian khusus sesuai kondisi hewan', 'harga': 'Rp 200.000'},
          ];
    final List<String> catatan = const [
      'Setiap tambah hari total biaya di (*) kali 2',
      'Setiap penitipan sudah termasuk kebutuhan dasar',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ── Top Bar ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 16, color: AppColors.textDark),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Judul ─────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Informasi',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Harga Per -1 hari ${hewan.toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Penitipan ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Penitipan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hargaPenitipan,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGrey,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.black, thickness: 0.5),
                    const SizedBox(height: 12),

                    // ── Tidak Termasuk ───────────────────────────
                    const Text(
                      'Tidak termasuk :',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 6),
                    ...tidakTermasuk.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textDark,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Expanded(
                            child: Text(item,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textDark,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Detail Harga ──────────────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Detail Harga',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...detailHarga.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textDark,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['label']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textDark,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(item['harga']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textDark,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Catatan ───────────────────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Catatan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...catatan.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textDark,
                            ),
                          ),
                          Expanded(
                            child: Text(item,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textDark,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Tombol Arrow (sesuai Figma) ───────────────────
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.textPurple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
