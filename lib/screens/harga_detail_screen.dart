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
    const Color teksSubTegas = Color(0xFF555555);    

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Stack(
        children: [
          // Background Efek Gradasi Atas Pastel
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
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
                            'Informasi',
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
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data.assetIcon,
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Harga Per -1 hari ${data.jenisHewan}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: teksUtamaPekat,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 24),

                        // KOTAK CARD UTAMA
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // === SECTION 1: PENITIPAN ===
                              const Text(
                                'Penitipan',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: teksSubTegas, 
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                data.hargaPerHari,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: teksUtamaPekat, 
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text(
                                'Tidak termasuk :',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: teksSubTegas, 
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildBulletItem('Kesehatan & keamanan', textColor: teksSubTegas),
                              _buildBulletItem('Aktivitas & kenyamanan', textColor: teksSubTegas),
                              _buildBulletItem('Perhatian khusus sesuai kondisi hewan', textColor: teksSubTegas),
                              const SizedBox(height: 16),

                              // =========================================================
                              // ─── 🛠️ SEGMEN DETAIL HARGA (DIHIMPIT ATAS BAWAH) ───
                              // =========================================================
                              const Divider(color: Color(0xFFDDDDDD), thickness: 1.2, height: 1),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(
                                  child: Text(
                                    'Detail Harga',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: teksUtamaPekat,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: Color(0xFFDDDDDD), thickness: 1.2, height: 1),
                              // =========================================================

                              const SizedBox(height: 20),
                              _buildHargaRow('Kesehatan & keamanan', data.hargaKesehatan, titleColor: teksSubTegas, priceColor: teksUtamaPekat),
                              const SizedBox(height: 16),
                              _buildHargaRow('Aktivitas & kenyamanan', data.hargaAktivitas, titleColor: teksSubTegas, priceColor: teksUtamaPekat),
                              const SizedBox(height: 16),
                              _buildHargaRow('Perhatian khusus sesuai kondisi hewan', data.hargaPerhatianKhusus, titleColor: teksSubTegas, priceColor: teksUtamaPekat),
                              const SizedBox(height: 20),

                              // =========================================================
                              // ─── 🛠️ SEGMEN CATATAN (DIHIMPIT ATAS BAWAH) ───
                              // =========================================================
                              const Divider(color: Color(0xFFDDDDDD), thickness: 1.2, height: 1),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(
                                  child: Text(
                                    'Catatan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: teksUtamaPekat,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: Color(0xFFDDDDDD), thickness: 1.2, height: 1),
                              // =========================================================

                              const SizedBox(height: 16),
                              _buildBulletItem('Setiap tambah hari total biaya di (*) kali 2', textColor: teksUtamaPekat, isBold: true),
                              _buildBulletItem('Setiap penitipan sudah termasuk kebutuhan dasar', textColor: teksUtamaPekat, isBold: true),
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

          // Tombol Navigasi Bulat Biru Gelap
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3A5F),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A3A5F).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, {required Color textColor, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•  ',
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontFamily: 'Nunito',
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHargaRow(String title, String price, {required Color titleColor, required Color priceColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('•  ', style: TextStyle(color: titleColor, fontSize: 14)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: titleColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            price,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700, 
              color: priceColor,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ],
    );
  }
}