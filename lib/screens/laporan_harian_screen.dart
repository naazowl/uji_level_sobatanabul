import 'package:flutter/material.dart';

class LaporanHarianScreen extends StatefulWidget {
  const LaporanHarianScreen({Key? key}) : super(key: key);

  @override
  State<LaporanHarianScreen> createState() => _LaporanHarianScreenState();
}

class _LaporanHarianScreenState extends State<LaporanHarianScreen> {
  final String date = "05/05/26";
  final String mood = "Baik";

  /// Jalur asset gambar lokal.
  final List<Map<String, String>> localPhotos = [
    {'assetPath': 'assets/images/mandi.jpg', 'title': 'Mandi 08:00'},
    {'assetPath': 'assets/images/makan.jpg', 'title': 'Makan 09:00'},
    {'assetPath': 'assets/images/bermain.jpg', 'title': 'Bermain 10:00'},
    {'assetPath': 'assets/images/tidur.webp', 'title': 'Tidur Siang 12:00'},
    {'assetPath': 'assets/images/jalan.jpg', 'title': 'Jalan Sore 16:00'},
  ];

  // List checklist kegiatan dengan kombinasi palet warna pastel aesthetic
  final List<Map<String, dynamic>> activities = [
    {'name': 'Mandi', 'color': const Color(0xFFFFB3B3)},       // Soft Pastel Pink Red
    {'name': 'Makan', 'color': const Color(0xFFE1BEE7)},       // Soft Pastel Light Purple
    {'name': 'Bermain', 'color': const Color(0xFFC8E6C9)},     // Soft Pastel Mint Green
    {'name': 'Tidur Siang', 'color': const Color(0xFFFFE0B2)}, // Soft Pastel Apricot Orange
    {'name': 'Jalan Sore', 'color': const Color(0xFFFFF9C4)},  // Soft Pastel Cream Yellow
  ];

  @override
  Widget build(BuildContext context) {
    // Token warna tema utama untuk kesan UI premium & bersih
    const Color aestheticDarkText = Color(0xFF1E293B);
    const Color aestheticBlueAccent = Color(0xFF4F93E3);
    const Color subTextColor = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Slate super light background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: aestheticDarkText, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Laporan Harian',
          style: TextStyle(
            color: aestheticDarkText, 
            fontWeight: FontWeight.w800, 
            fontSize: 22, 
            fontFamily: 'Nunito',
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── HEADER SECTION: Tanggal & Mood Chip ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hari Ini',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: aestheticDarkText,
                          fontSize: 18,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // Mood Chip Badge Modern
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE), // Soft light blue bg
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBAE6FD), width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wb_sunny_rounded, color: aestheticBlueAccent, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Mood: $mood',
                          style: const TextStyle(
                            color: Color(0xFF0369A1),
                            fontSize: 13,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── HORIZONTAL SLIDER FOTO KUCING ──
            SizedBox(
              height: 290, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: localPhotos.length,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemBuilder: (context, index) {
                  return Container(
                    width: 190,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pembungkus Foto dengan Shadow Halus Premium
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0F172A).withOpacity(0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                localPhotos[index]['assetPath']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFF1F5F9),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.insert_photo_outlined, color: Colors.grey[400], size: 32),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Taruh gambar di:\n${localPhotos[index]['assetPath']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey[500], 
                                            fontSize: 10, 
                                            fontFamily: 'Nunito',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Keterangan Teks Kegiatan di bawah masing-masing foto
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            localPhotos[index]['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700, 
                              fontSize: 14, 
                              color: aestheticDarkText,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // ── SECTION BAWAH: KEGIATAN HARI INI ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        decoration: BoxDecoration(
                          color: aestheticBlueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Aktivitas Terpenuhi',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w800, 
                          color: aestheticDarkText, 
                          fontFamily: 'Nunito',
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Grid/List List Kegiatan dengan Box Container yang Penuh & Cantik
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFF1F5F9), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0F172A).withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            // Bulatan Indikator Checklist Cantik
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: activities[index]['color'].withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: activities[index]['color'],
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Nama Kegiatan
                            Text(
                              activities[index]['name'],
                              style: const TextStyle(
                                fontSize: 15, 
                                fontWeight: FontWeight.w700, 
                                fontFamily: 'Nunito',
                                color: aestheticDarkText,
                              ),
                            ),
                            const Spacer(),
                            // Badge Penanda Waktu / Status Tambahan
                            Text(
                              'Selesai',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Colors.green[400],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32), // Padding bawah agar scroll terasa lega
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}