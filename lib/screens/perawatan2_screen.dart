import 'package:flutter/material.dart';
import 'pembayaran_screen.dart'; // 📍 Memastikan file pembayaran terhubung

// 1. DATA MODEL
class PerawatanCategory {
  final String title;
  final String hargaLabel;
  final int hargaValue;
  final List<String> items;

  const PerawatanCategory({
    required this.title,
    required this.hargaLabel,
    required this.hargaValue,
    required this.items,
  });
}

class SelectedCategory {
  final String title;
  final int hargaPerHari;
  const SelectedCategory({required this.title, required this.hargaPerHari});
}

// 2. SCREEN UTAMA
class PerawatanScreen extends StatefulWidget {
  final String petName;
  final String petType; 
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;

  const PerawatanScreen({
    super.key,
    required this.petName,
    required this.petType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
  });

  @override
  State<PerawatanScreen> createState() => _PerawatanScreenState();
}

class _PerawatanScreenState extends State<PerawatanScreen> {
  late final List<PerawatanCategory> _categories;

  // Set default ke 0 agar "Kebutuhan Dasar" otomatis terpilih sejak awal
  final Set<int> _selected = {0}; 
  final Set<int> _expanded = {0}; 

  @override
  void initState() {
    super.initState();

    final isAnjing = widget.petType.toLowerCase().contains('anjing');

    _categories = [
      PerawatanCategory(
        title: 'Kebutuhan Dasar',
        hargaLabel: isAnjing ? 'Rp 110.000 / hari' : 'Rp 100.000 / hari', 
        hargaValue: isAnjing ? 110000 : 100000, 
        items: [
          'Pemberian makan & minum sesuai jadwal',
          'Pengaturan porsi makan',
          'Membersihkan kandang / litter box',
          'Grooming dasar (mandi, sisir bulu ringan)',
          'Menjaga kebersihan tubuh dan lingkungan hewan',
        ],
      ),
      PerawatanCategory(
        title: 'Kesehatan & keamanan',
        hargaLabel: isAnjing ? 'Rp 120.000 / hari' : 'Rp 100.000 / hari',
        hargaValue: isAnjing ? 120000 : 100000,
        items: [
          'Monitoring kondisi fisik harian',
          'Pengecekan kesehatan dasar',
          'Pemberian obat (jika diperlukan)',
          'Pengawasan 24 jam / sistem keamanan',
          'Penanganan darurat & kontak dokter hewan',
        ],
      ),
      PerawatanCategory(
        title: 'Aktivitas & kenyamanan',
        hargaLabel: isAnjing ? 'Rp 100.000 / hari' : 'Rp 80.000 / hari',
        hargaValue: isAnjing ? 100000 : 80000,
        items: [
          'Waktu bermain (playtime)',
          'Jalan-jalan (khusus anjing)',
          'Mainan & stimulasi mental',
          'Tempat istirahat yang nyaman',
          'Interaksi dengan caregiver',
        ],
      ),
      PerawatanCategory(
        title: 'Perhatian khusus sesuai kondisi hewan',
        hargaLabel: isAnjing ? 'Rp 200.000 / hari' : 'Rp 150.000 / hari',
        hargaValue: isAnjing ? 200000 : 150000,
        items: [
          'Perawatan hewan lansia',
          'Perawatan hewan sakit / pemulihan',
          'Penanganan hewan dengan kecemasan',
          'Diet atau jadwal khusus',
          'Pengawasan ekstra & perhatian lebih intens',
        ],
      ),
    ];
  }

  void _toggleSelect(int index) {
    setState(() {
      // Indeks 0 (Kebutuhan Dasar) wajib dicentang, tidak bisa di-unselect
      if (index == 0) return; 
      
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else {
        _selected.add(index);
      }
    });
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expanded.contains(index)) {
        _expanded.remove(index);
      } else {
        _expanded.add(index);
      }
    });
  }

  final List<String> _monthNames = [
    'Jan','Feb','Mar','Apr','Mei','Jun',
    'Jul','Agu','Sep','Okt','Nov','Des'
  ];

  String _fmtDate(DateTime d) => '${d.day} ${_monthNames[d.month - 1]} ${d.year}';

  void _onSelanjutnya() {
    final selectedList = _selected
        .map((i) => SelectedCategory(
              title: _categories[i].title,
              hargaPerHari: _categories[i].hargaValue,
            ))
        .toList();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RincianHargaScreen(
          petName: widget.petName,
          petType: widget.petType,
          startDate: widget.startDate,
          endDate: widget.endDate,
          totalDays: widget.totalDays,
          selectedCategories: selectedList,
        ),
      ),
    ).then((v) {
      if (!mounted) return;
      if (v != null) Navigator.pop(context, v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFD6EFFA),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text('Perawatan',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                        ),
                      ),
                      const SizedBox(width: 36),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(Icons.pets, size: 15, color: Color(0xFFFF8C42)),
                          const SizedBox(width: 5),
                          Text('${widget.petName} (${widget.petType})',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFFFF8C42))),
                        ]),
                        Text('${_fmtDate(widget.startDate)} → ${_fmtDate(widget.endDate)}',
                          style: const TextStyle(fontSize: 11, color: Colors.black54)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8C42),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('${widget.totalDays} hari',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('"Pilih perawatan tambahan sesuai kebutuhan!"',
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600, color: Color(0xFF2B7BB9))),
              ),
            ),

            // ── LIST KATEGORI OPSI ─────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                itemCount: _categories.length,
                itemBuilder: (_, i) => _buildCard(i),
              ),
            ),

            // ── TOMBOL SUBMIT ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: GestureDetector(
                onTap: _onSelanjutnya,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(
                      color: const Color(0xFFFF8C42).withValues(alpha: 0.35),
                      blurRadius: 12, offset: const Offset(0, 4),
                    )],
                  ),
                  child: const Text('Selanjutnya',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int i) {
    final cat = _categories[i];
    final isSelected = _selected.contains(i);
    final isExpanded = _expanded.contains(i);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEAF4FB) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? const Color(0xFF2B7BB9).withValues(alpha: 0.4) : Colors.grey.shade200,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected ? const Color(0xFF2B7BB9).withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10, offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _toggleSelect(i);
              if (!_expanded.contains(i)) _toggleExpand(i);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24, height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2B7BB9) : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.title,
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800,
                            color: isSelected ? const Color(0xFF1A1A1A) : Colors.black54)),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8C42).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat.hargaLabel,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFFF8C42)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleExpand(i),
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      size: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                children: [
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 8),
                  ...cat.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          width: 5, height: 5,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF2B7BB9) : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.black87 : Colors.black38,
                              height: 1.4)),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

// 3. SCREEN STRUK HARGA
class RincianHargaScreen extends StatelessWidget {
  final String petName;
  final String petType;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final List<SelectedCategory> selectedCategories;

  const RincianHargaScreen({
    super.key,
    required this.petName,
    required this.petType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.selectedCategories,
  });

  String _fmtRp(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp ${buf.toString()}';
  }

  final List<String> _monthNames = const [
    'Jan','Feb','Mar','Apr','Mei','Jun',
    'Jul','Agu','Sep','Okt','Nov','Des'
  ];

  String _fmtDate(DateTime d) => '${d.day} ${_monthNames[d.month - 1]} ${d.year}';

  @override
  Widget build(BuildContext context) {
    // Menghitung grand total berdasarkan seluruh kategori yang dicentang
    int grandTotal = 0;
    for (final c in selectedCategories) {
      grandTotal += c.hargaPerHari * totalDays;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              decoration: const BoxDecoration(
                color: Color(0xFFD6EFFA),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Rincian Harga',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16, offset: const Offset(0, 4),
                        )],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF8C42),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.receipt_long_rounded, color: Colors.white, size: 32),
                                const SizedBox(height: 6),
                                const Text('SobatAnabul',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900,
                                      color: Colors.white, letterSpacing: 0.5)),
                                const SizedBox(height: 4),
                                Text('Struk Ringkasan Biaya ($petType)',
                                  style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow('Nama Hewan', petName),
                                _buildInfoRow('Jenis Hewan', petType),
                                _buildInfoRow('Waktu Titip', '${_fmtDate(startDate)} - ${_fmtDate(endDate)}'),
                                _buildInfoRow('Durasi', '$totalDays Hari'),

                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Divider(color: Color(0xFFEEEEEE)),
                                ),

                                const Text('Daftar Biaya Terhitung:',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                                const SizedBox(height: 12),

                                // Loop dinamis merender item layanan yang dipilih termasuk "Kebutuhan Dasar"
                                ...selectedCategories.map((c) => _buildBiayaRow(
                                  c.title,
                                  '${_fmtRp(c.hargaPerHari)} × $totalDays hari',
                                  c.hargaPerHari * totalDays,
                                  c.title == 'Kebutuhan Dasar' ? Colors.green : const Color(0xFF2B7BB9),
                                )),

                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Divider(color: Color(0xFFEEEEEE), thickness: 1.5),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('TOTAL AKHIR',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                                    Text(_fmtRp(grandTotal),
                                      style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w900,
                                        color: Color(0xFFFF8C42))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 📍 Navigasi Tombol Maju ke PembayaranScreen
                    GestureDetector(
                      onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PembayaranScreen(
                            grandTotal: grandTotal,
                            petName: petName,
                            petType: petType,
                            startDate: startDate,
                            endDate: endDate,
                            totalDays: totalDays,
                            selectedCategories: selectedCategories
                                .map((c) => {
                                      'title': c.title,
                                      'hargaPerHari': c.hargaPerHari,
                                    })
                                .toList(),
                          ),
                        ),
                      );

                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8C42),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(
                              color: const Color(0xFFFF8C42).withValues(alpha: 0.35),
                              blurRadius: 12, offset: const Offset(0, 4),
                            )],
                          ),
                          child: const Text('Konfirmasi Pembayaran',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
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

    Widget _buildInfoRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }

  Widget _buildBiayaRow(String title, String subtitle, int total, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Text(_fmtRp(total), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}