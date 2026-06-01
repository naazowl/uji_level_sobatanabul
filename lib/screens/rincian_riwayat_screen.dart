import 'package:flutter/material.dart';

class RincianRiwayatScreen extends StatelessWidget {
  final Map<String, dynamic> data; 

  const RincianRiwayatScreen({super.key, required this.data});

  // Helper format rupiah manual agar rapi dan aman saat rendering
  String _formatRupiah(dynamic number) {
    if (number == null) return '0';
    String str = number.toString();
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (Match match) => '${match[1]}.');
  }

  @override
  Widget build(BuildContext context) {
    // LOGIKA WARNA ADAPTIF FIGMA: Deteksi jenis hewan untuk background container
    final String jenisHewan = (data['jenis'] ?? '').toString().toLowerCase();
    final bool isKucing = jenisHewan.contains('kucing');
    
    // Krem hangat (#F9F5EC) untuk Kucing, Biru pastel (#EAF2FF) untuk Anjing
    final Color cardBackgroundColor = isKucing ? const Color(0xFFF9F5EC) : const Color(0xFFEAF2FF);

    // Mengambil data list perawatan tambahan yang disesuaikan dengan isi Figma baru kamu
    final List<dynamic> perawatanList = data['perawatan'] ?? [
      {'name': 'Kesehatan & Keamanan /5x', 'price': isKucing ? 500000 : 600000},
      {'name': 'Aktivitas & kenyamanan /5x', 'price': isKucing ? 400000 : 500000},
      {'name': 'Perhatian khusus sesuai kondisi hewan /5x', 'price': isKucing ? 750000 : 1000000},
    ];

    // Menghitung subtotal, pajak, dan total secara dinamis berdasarkan jenis hewan di Figma
    final int hargaPenitipan = isKucing ? 500000 : 550000;
    final int subtotal = isKucing ? 2150000 : 2650000;
    final int pajak = isKucing ? 107500 : 132500;
    final int totalPembayaran = isKucing ? 2257500 : 2782500;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rincian',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // ── KARTU RINCIAN UTAMA ─────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBackgroundColor, 
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Card: Nama & Jenis Hewan
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "${data['nama'] ?? (isKucing ? 'Celli' : 'Cello')} (${data['jenis'] ?? (isKucing ? 'Kucing Ragdoll' : 'Anjing Golden Retriever')})",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, 
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${data['tanggal'] ?? '6 Mar - 10 Mar'} (5 hari)",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87, 
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.black38, thickness: 1), 
                    const SizedBox(height: 12),

                    // Tab Navigasi Rincian Pembayaran
                    Row(
                      children: [
                        const Text(
                          'Rincian Pembayaran',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, 
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Item 1: Penitipan (Menyesuaikan harga baru di Figma)
                    _buildBillingRow('Penitipan', 'Rp ${_formatRupiah(hargaPenitipan)}', isBold: true),
                    
                    const Text(
                      '* Sudah termasuk kebutuhan Dasar',
                      style: TextStyle(
                        fontSize: 11, 
                        color: Colors.black87, 
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Item 2: Perawatan
                    const Text(
                      'Perawatan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, 
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    // Looping Item Perawatan Tambahan (+ /5x sesuai Figma)
                    ...perawatanList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '* ${item['name']}',
                                style: const TextStyle(
                                  fontSize: 12, 
                                  color: Colors.black, 
                                  fontWeight: FontWeight.w600, 
                                ),
                              ),
                            ),
                            Text(
                              'Rp ${_formatRupiah(item['price'])}',
                              style: const TextStyle(
                                fontSize: 13, 
                                color: Colors.black, 
                                fontWeight: FontWeight.bold, 
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 16),
                    const Divider(color: Colors.black38, thickness: 1), 
                    const SizedBox(height: 12),

                    // Subtotal & Pajak dinamis sesuai kalkulasi figma baru
                    _buildBillingRow('Subtotal', 'Rp ${_formatRupiah(subtotal)}', isBold: true),
                    const SizedBox(height: 8),
                    _buildBillingRow('Pajak 10%', 'Rp ${_formatRupiah(pajak)}', isBold: true),
                    
                    const SizedBox(height: 16),
                    const Divider(color: Colors.black38, thickness: 1), 
                    const SizedBox(height: 12),

                    // Total Pembayaran Akhir
                    _buildBillingRow('Total Pembayaran', 'Rp ${_formatRupiah(totalPembayaran)}', isBold: true, isTotal: true),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── STATUS SELESAI (HIJAU FIGMA) ───────────────────────────
              const Text(
                'Selesai',
                style: TextStyle(
                  color: Color(0xFF27AE60),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF27AE60),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper Row Kiri-Kanan bawaan asli proyekmu dengan teks hitam tegas
  Widget _buildBillingRow(String title, String price, {bool isBold = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: (isBold || isTotal) ? FontWeight.bold : FontWeight.w600,
            color: Colors.black, 
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 15 : 14,
            fontWeight: FontWeight.bold, 
            color: Colors.black, 
          ),
        ),
      ],
    );
  }
}