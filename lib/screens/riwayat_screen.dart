import 'package:flutter/material.dart';
import 'package:app1/models/riwayat_provider.dart';

// ── Helper format ─────────────────────────────────────────────────────────────
String _fmtRp(int amount) {
  final s = amount.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp ${buf.toString()}';
}

const _months = [
  'Jan','Feb','Mar','Apr','Mei','Jun',
  'Jul','Agu','Sep','Okt','Nov','Des'
];
String _fmtDate(DateTime d) => '${d.day} ${_months[d.month - 1]}, ${d.year}';
String _fmtDateShort(DateTime d) => '${d.day} ${_months[d.month - 1]}';

// ── Status config ─────────────────────────────────────────────────────────────
Map<String, dynamic> _statusConfig(StatusTitipan s) {
  switch (s) {
    case StatusTitipan.menunggu:
      return {
        'label': 'Menunggu',
        'sublabel': 'Sudah dibayar · Belum dititipkan',
        'color': const Color(0xFF2B7BB9),
        'bg': const Color(0xFFE8F4FD),
        'icon': Icons.schedule_rounded,
      };
    case StatusTitipan.sedangDititip:
      return {
        'label': 'Sedang Dititip',
        'sublabel': 'Hewan Anda sedang dalam perawatan',
        'color': const Color(0xFFFF8C42),
        'bg': const Color(0xFFFFF3EB),
        'icon': Icons.pets_rounded,
      };
    case StatusTitipan.selesai:
      return {
        'label': 'Selesai',
        'sublabel': 'Penitipan telah selesai',
        'color': const Color(0xFF4CAF50),
        'bg': const Color(0xFFEDF7EE),
        'icon': Icons.check_circle_rounded,
      };
  }
}

// ── Main Screen ───────────────────────────────────────────────────────────────
class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  Widget build(BuildContext context) {
    final items = RiwayatProvider().items;

    // Pisahkan aktif (menunggu/sedang) dan selesai
    final aktif = items
        .where((i) => i.status != StatusTitipan.selesai)
        .toList();
    final selesai = items
        .where((i) => i.status == StatusTitipan.selesai)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new,
                            size: 20, color: Colors.black),
                      ),
                      const SizedBox(width: 16),
                      const Text('Riwayat',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    ],
                  ),
                  
                ],
              ),
            ),

            // ── KONTEN ──────────────────────────────────
            Expanded(
              child: items.isEmpty
                  ? _buildKosong()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Aktif section
                          if (aktif.isNotEmpty) ...[
                            _sectionTitle('Aktif', aktif.length),
                            const SizedBox(height: 10),
                            ...aktif.map((item) =>
                                _buildCard(item, context)),
                            const SizedBox(height: 20),
                          ],

                          // Selesai section
                          if (selesai.isNotEmpty) ...[
                            _sectionTitle('Riwayat Sebelumnya',
                                selesai.length),
                            const SizedBox(height: 10),
                            ...selesai.map((item) =>
                                _buildCard(item, context)),
                          ],

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, int count) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black87)),
        const SizedBox(width: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          child: Text('$count',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700)),
        ),
      ],
    );
  }

  Widget _buildCard(RiwayatItem item, BuildContext context) {
    final cfg = _statusConfig(item.status);
    final Color statusColor = cfg['color'];
    final Color statusBg = cfg['bg'];
    final String statusLabel = cfg['label'];
    final String statusSublabel = cfg['sublabel'];
    final IconData statusIcon = cfg['icon'];

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.delete_sweep_rounded,
            color: Colors.red.shade400, size: 28),
      ),
      onDismissed: (_) {
        RiwayatProvider().hapus(item.id);
        setState(() {});
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => RiwayatDetailScreen(item: item)),
        ).then((_) => setState(() {})),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            children: [
              // ── Status bar atas ──────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    const SizedBox(width: 6),
                    Text(statusLabel,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: statusColor)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(statusSublabel,
                          style: TextStyle(
                              fontSize: 11,
                              color: statusColor.withOpacity(0.7))),
                    ),
                  ],
                ),
              ),

              // ── Isi kartu (mirip screenshot lama) ───
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto placeholder (kotak abu)
                    Container(
                      width: 70, height: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.pets_rounded,
                          color: Colors.grey.shade400, size: 30),
                    ),
                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tanggal
                          Text(
                            '${_fmtDateShort(item.startDate)} - ${_fmtDateShort(item.endDate)}, ${item.endDate.year}',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          // Nama hewan
                          Text('Nama Hewan: ${item.petName}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87)),
                          Text('Jenis: ${item.petType}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54)),

                          // Kegiatan (dari selectedCategories)
                          Text(
                            'Layanan: ${item.selectedCategories.map((c) => c['title'].toString().split(' ').first).join(', ')}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // Total
                          Text('Total: ${_fmtRp(item.grandTotal)}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Tombol Rincian ───────────────────────
              Padding(
                padding:
                    const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              RiwayatDetailScreen(item: item)),
                    ).then((_) => setState(() {})),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Rincian',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _konfirmasiHapusSemua(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Semua Riwayat?'),
        content:
            const Text('Semua data riwayat penitipan akan dihapus.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          TextButton(
            onPressed: () {
              RiwayatProvider().hapusSemua();
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Hapus',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildKosong() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90, height: 90,
            decoration: BoxDecoration(
                color: Colors.grey.shade100, shape: BoxShape.circle),
            child: Icon(Icons.history_rounded,
                size: 44, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 16),
          const Text('Belum ada riwayat titipan',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            'Riwayat akan muncul setelah pembayaran selesai.',
            style:
                TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ── Detail Screen ─────────────────────────────────────────────────────────────
class RiwayatDetailScreen extends StatelessWidget {
  final RiwayatItem item;
  const RiwayatDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cfg = _statusConfig(item.status);
    final Color statusColor = cfg['color'];
    final Color statusBg = cfg['bg'];
    final String statusLabel = cfg['label'];
    final String statusSublabel = cfg['sublabel'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ──────────────────────────────────
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
                          shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 16, color: Colors.black),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Detail Riwayat',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // ── Status Banner ────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                shape: BoxShape.circle),
                            child: Icon(cfg['icon'],
                                color: statusColor, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(statusLabel,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: statusColor)),
                                Text(statusSublabel,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: statusColor
                                            .withOpacity(0.75))),
                              ],
                            ),
                          ),
                          // Info tambahan per status
                          _buildStatusExtra(item.status),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Struk ────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header orange
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF8C42),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            child: Column(children: [
                              const Icon(Icons.receipt_long_rounded,
                                  color: Colors.white, size: 32),
                              const SizedBox(height: 6),
                              const Text('SobatAnabul',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white)),
                              const SizedBox(height: 4),
                              Text(
                                'Struk Penitipan ${item.petType}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                          ),

                          // Info rows
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                _infoRow('Nama Hewan', item.petName),
                                _infoRow('Jenis Hewan', item.petType),
                                _infoRow('Tanggal Masuk',
                                    _fmtDate(item.startDate)),
                                _infoRow('Tanggal Keluar',
                                    _fmtDate(item.endDate)),
                                _infoRow('Durasi',
                                    '${item.totalDays} Hari'),
                                _infoRow('Metode Bayar',
                                    item.metodePembayaran),
                                _infoRow('Tgl Transaksi',
                                    _fmtDate(item.createdAt)),

                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Divider(
                                        color: Color(0xFFEEEEEE))),

                                const Text('Daftar Layanan:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800)),
                                const SizedBox(height: 12),

                                ...item.selectedCategories
                                    .map((c) => _biayaRow(
                                          c['title'] as String,
                                          '${_fmtRp(c['hargaPerHari'] as int)} × ${item.totalDays} hari',
                                          (c['hargaPerHari'] as int) *
                                              item.totalDays,
                                          c['title'] ==
                                                  'Kebutuhan Dasar'
                                              ? Colors.green
                                              : const Color(
                                                  0xFF2B7BB9),
                                        )),

                                const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Divider(
                                        color: Color(0xFFEEEEEE),
                                        thickness: 1.5)),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('TOTAL AKHIR',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight.w900)),
                                    Text(_fmtRp(item.grandTotal),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFFFF8C42))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Badge lunas ──────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: Colors.green.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_rounded,
                              color: Colors.green.shade600, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Pembayaran Lunas via ${item.metodePembayaran}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.green.shade700),
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
    );
  }

  Widget _buildStatusExtra(StatusTitipan status) {
    final now = DateTime.now();
    switch (status) {
      case StatusTitipan.menunggu:
        final selisih = item.startDate.difference(now).inDays;
        return Column(
          children: [
            Text('${selisih + 1}',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2B7BB9))),
            const Text('hari lagi',
                style: TextStyle(fontSize: 10, color: Color(0xFF2B7BB9))),
          ],
        );
      case StatusTitipan.sedangDititip:
        final selisih = item.endDate.difference(now).inDays;
        return Column(
          children: [
            Text('${selisih + 1}',
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFF8C42))),
            const Text('hari lagi\nselesai',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 10, color: Color(0xFFFF8C42))),
          ],
        );
      case StatusTitipan.selesai:
        return const Icon(Icons.check_circle_rounded,
            color: Color(0xFF4CAF50), size: 28);
    }
  }

  Widget _infoRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(fontSize: 13, color: Colors.grey)),
            Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      );

  Widget _biayaRow(
      String title, String subtitle, int total, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Text(_fmtRp(total),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}
