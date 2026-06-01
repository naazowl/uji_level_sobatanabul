import 'package:flutter/material.dart';
import 'package:app1/models/riwayat_provider.dart';

class PembayaranScreen extends StatefulWidget {
  final int grandTotal;
  final String petName;
  final String petType;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final List<Map<String, dynamic>> selectedCategories;

  const PembayaranScreen({
    super.key,
    required this.grandTotal,
    required this.petName,
    required this.petType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.selectedCategories,
  });

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String _selectedMethod = 'QRIS';

  String _fmtRp(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${buf.toString()}';
  }

  void _prosesPembayaranSelesai() {
    // ── Simpan ke Riwayat ──────────────────────────────────
    final item = RiwayatItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      petName: widget.petName,
      petType: widget.petType,
      startDate: widget.startDate,
      endDate: widget.endDate,
      totalDays: widget.totalDays,
      selectedCategories: widget.selectedCategories,
      grandTotal: widget.grandTotal,
      metodePembayaran: _selectedMethod,
      createdAt: DateTime.now(),
    );
    RiwayatProvider().tambah(item);

    // ── Dialog Sukses ──────────────────────────────────────
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text('Sukses!', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        content: Text(
          'Pembayaran menggunakan $_selectedMethod berhasil diproses. '
          'Terima kasih telah memercayakan peliharaan Anda di SobatAnabul!\n\n'
          'Cek riwayat titipan di menu Riwayat. 🐾',
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('Kembali ke Beranda',
                style: TextStyle(
                    color: Color(0xFFFF8C42), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFD6EFFA),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 16, color: Colors.black),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Metode Pembayaran',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900)),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // ── TOTAL TAGIHAN ───────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Tagihan',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 4),
                        const Text('SobatAnabul Care',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.petName} · ${widget.totalDays} hari',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(_fmtRp(widget.grandTotal),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFF8C42))),
                  ],
                ),
              ),
            ),

            // ── METODE PEMBAYARAN ───────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih Metode Pembayaran:',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Colors.black87)),
                    const SizedBox(height: 12),
                    _buildMethodTile(
                        id: 'QRIS',
                        title: 'QRIS (Gopay, OVO, Dana, LinkAja)',
                        icon: Icons.qr_code_scanner_rounded,
                        color: Colors.purple),
                    _buildMethodTile(
                        id: 'GoPay',
                        title: 'GoPay E-Wallet',
                        icon: Icons.account_balance_wallet_rounded,
                        color: Colors.blue),
                    _buildMethodTile(
                        id: 'Cash',
                        title: 'Bayar Tunai di Kasir (Cash)',
                        icon: Icons.payments_rounded,
                        color: Colors.green),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 10),
                    _buildDynamicPaymentArea(),
                  ],
                ),
              ),
            ),

            // ── TOMBOL BAYAR ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: GestureDetector(
                onTap: _prosesPembayaranSelesai,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFFF8C42).withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Text(
                    _selectedMethod == 'Cash'
                        ? 'Selesaikan Reservasi'
                        : 'Bayar Sekarang',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTile(
      {required String id,
      required String title,
      required IconData icon,
      required Color color}) {
    final isSelected = _selectedMethod == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected ? color : Colors.grey.shade200,
              width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color:
                          isSelected ? Colors.black : Colors.black87)),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected ? color : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicPaymentArea() {
    if (_selectedMethod == 'QRIS') {
      return Center(
        child: Column(
          children: [
            const Text('Scan QRIS untuk Menyelesaikan Pembayaran',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                children: [
                  Container(
                    width: 160, height: 160,
                    color: Colors.grey.shade100,
                    child: const Icon(Icons.qr_code_2_rounded,
                        size: 140, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text('SOBATANABUL_PETCARE.NMN',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5)),
                  const Text('NMID: ID10293847561',
                      style: TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_selectedMethod == 'GoPay') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blue.withOpacity(0.2))),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: Colors.blue, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Aplikasi SobatAnabul akan langsung menghubungkan Anda ke sistem Gojek untuk memotong saldo e-wallet.',
                style:
                    TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.green.withOpacity(0.2))),
        child: const Row(
          children: [
            Icon(Icons.storefront_rounded, color: Colors.green, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Lakukan Pembayaran tunai di meja kasir toko SobatAnabul saat mengantarkan peliharaan ke lokasi penitipan.',
                style:
                    TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
              ),
            ),
          ],
        ),
      );
    }
  }
}
