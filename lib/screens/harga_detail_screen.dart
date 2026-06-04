import 'package:flutter/material.dart';
import 'package:app1/theme/app_theme.dart'; 

class HargaDetailData {
  final String jenisHewan;
  final String hargaPerHari;
  final String hargaKesehatan;
  final String hargaAktivitas;
  final String hargaPerhatianKhusus;
  final Color startColor;
  final Color endColor;
  final String assetIcon;

  const HargaDetailData({
    required this.jenisHewan,
    required this.hargaPerHari,
    required this.hargaKesehatan,
    required this.hargaAktivitas,
    required this.hargaPerhatianKhusus,
    required this.startColor,
    required this.endColor,
    required this.assetIcon,
  });
}

final Map<String, HargaDetailData> _hargaDataMap = {
  'Kucing': const HargaDetailData(
    jenisHewan: 'kucing',
    hargaPerHari: 'Rp 100.000',
    hargaKesehatan: 'Rp 100.000',
    hargaAktivitas: 'Rp 80.000',
    hargaPerhatianKhusus: 'Rp 150.000',
    startColor: Color(0xFFFFE5C4), 
    endColor: Color(0xFFFFF6EB),
    assetIcon: '🐱',
  ),
  'Anjing': const HargaDetailData(
    jenisHewan: 'anjing',
    hargaPerHari: 'Rp 110.000', 
    hargaKesehatan: 'Rp 120.000',
    hargaAktivitas: 'Rp 100.000',
    hargaPerhatianKhusus: 'Rp 200.000',
    startColor: Color(0xFFD6EFFF), 
    endColor: Color(0xFFAFDFFF),
    assetIcon: '🐶',
  ),
};

class HargaDetailScreen extends StatelessWidget {
  final String jenisHewan;

  const HargaDetailScreen({super.key, required this.jenisHewan});

  @override
  Widget build(BuildContext context) {
    final data = _hargaDataMap[jenisHewan] ?? _hargaDataMap['Kucing']!;

    const Color teksUtamaPekat = Color(0xFF1A1A1A);  
    const Color teksSubTegas = Color(0xFF666666);    
    final Color accentColor = data.jenisHewan == 'kucing' ? const Color(0xFFFF9F43) : const Color(0xFF2980B9);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Stack(
        children: [
          // Background Efek Gradasi Atas Pastel Lebih Tebal
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [data.startColor, data.endColor, AppColors.bgLight],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Konten Utama
          SafeArea(
            child: Column(
              children: [
                // Top Bar Layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: teksUtamaPekat,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Informasi Biaya',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: teksUtamaPekat,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 42), 
                    ],
                  ),
                ),

                // Area Scroll Card
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Lingkaran Icon Hewan Gedhe
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              )
                            ]
                          ),
                          child: Text(
                            data.assetIcon,
                            style: const TextStyle(fontSize: 54),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tarif Penitipan $jenisHewan',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: teksUtamaPekat,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // KOTAK CARD UTAMA MODERN
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              // === BIAYA UTAMA (HERO COMPONENT) ===
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [accentColor, accentColor.withOpacity(0.8)],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Biaya Dasar Penitipan',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70, 
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Termasuk Kebutuhan Dasar',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70,
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${data.hargaPerHari}/Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white, 
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // === SECTION: TIDAK TERMASUK ===
                              _buildSubHeader('Tidak Termasuk Layanan Khusus:'),
                              const SizedBox(height: 12),
                              _buildPengecualianItem('Kesehatan & keamanan medis ekstra'),
                              _buildPengecualianItem('Aktivitas bermain & kenyamanan khusus'),
                              _buildPengecualianItem('Perhatian intensif luar kondisi normal'),
                              const SizedBox(height: 28),

                              // === SECTION: DETAIL HARGA (MODEL GRID) ===
                              _buildSubHeader('Rincian Tarif Tambahan Opsional'),
                              const SizedBox(height: 16),
                              
                              // Row Grid Kolom Kiri Kanan biar keren
                              Row(
                                children: [
                                  Expanded(child: _buildGridHargaCard('Medis & Aman', data.hargaKesehatan, Icons.health_and_safety_rounded, const Color(0xFFE1F5FE), const Color(0xFF0288D1))),
                                  const SizedBox(width: 12),
                                  Expanded(child: _buildGridHargaCard('Playtime', data.hargaAktivitas, Icons.pets_rounded, const Color(0xFFE8F5E9), const Color(0xFF388E3C))),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildGridHargaCard(
                                'Perhatian Khusus / Kondisi Tertentu', 
                                data.hargaPerhatianKhusus, 
                                Icons.star_rounded, 
                                const Color(0xFFFFF3E0), 
                                const Color(0xFFF57C00),
                                isFullWidth: true
                              ),
                              const SizedBox(height: 28),

                              // === SECTION: CATATAN TARIF ===
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF9E6), 
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color(0xFFFFEAA7), width: 1.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.calculate_rounded, color: Color(0xFFD35400), size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'Sistem Kelipatan Biaya',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFFD35400),
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      '• Setiap penambahan hari, seluruh total komponen biaya pilihan akan dikalikan sesuai jumlah hari menginap ( x2, x3, dst ).',
                                      style: TextStyle(
                                        fontSize: 12, 
                                        color: Color(0xFF5E6A75), 
                                        fontFamily: 'Nunito',
                                        height: 1.4,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tombol Aksi bawah yang menyatu dengan tema
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A3A5F).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3A5F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Paham, Lanjutkan',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16, fontFamily: 'Nunito'),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Judul Bagian Dalam Card
  Widget _buildSubHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF1A1A1A), 
        fontWeight: FontWeight.w900,
        fontFamily: 'Nunito',
      ),
    );
  }

  // Helper List Pengecualian dengan ikon silang merah estetik
  Widget _buildPengecualianItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close_rounded, size: 12, color: Color(0xFFD32F2F)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Desain Kartu Rincian Grid Berwarna Cantik
  Widget _buildGridHargaCard(String title, String price, IconData icon, Color bgColor, Color iconColor, {bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54, fontFamily: 'Nunito'),
                ),
                const SizedBox(height: 2),
                Text(
                  price,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: iconColor, fontFamily: 'Nunito'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}