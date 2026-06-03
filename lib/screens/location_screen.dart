import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  static const String _address =
      'Jl. Raya Tajur, Kp. Buntar RT.02/RW.08, Kel. Muara sari, Kec. Bogor Selatan, RT.03/RW.08, Muarasari, Kec. Bogor Sel., Kota Bogor, Jawa Barat 16137';

  // Koordinat lokasi SobatAnabul
  static const double _lat = -6.6200;
  static const double _lng = 106.8283;

  Future<void> _openGoogleMaps() async {
    // 💡 Menggunakan String Interpolation (${...}) yang benar untuk mencari berdasarkan alamat teks
    final String queryUrl = "https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(_address)}";
    final Uri webNavUri = Uri.parse(queryUrl);

    // 💡 Trik untuk langsung memicu aplikasi native Google Maps di HP dengan rute navigasi
    final Uri nativeNavUri = Uri.parse("google.navigation:q=${Uri.encodeComponent(_address)}&mode=d");

    try {
      // 1. Coba buka aplikasi Google Maps native di HP dulu untuk langsung rute jalan
      if (await canLaunchUrl(nativeNavUri)) {
        await launchUrl(nativeNavUri);
      } 
      // 2. Fallback kalau di web browser / aplikasi native tidak merespon, buka via browser link rute
      else if (await canLaunchUrl(webNavUri)) {
        await launchUrl(webNavUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka peta.';
      }
    } catch (e) {
      debugPrint('Error membuka maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 💡 MEMBERIKAN JARAK AMAN AGAR TIDAK MENTOK TOP BARNYA
            const SizedBox(height: 28),

              // ── TOP BAR ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Tombol Back
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── LOGO & NAMA ──────────────────────────────────
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8C42),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.pets, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 12),
              const Text(
                'SobatAnabul',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2B7BB9),
                ),
              ),

              const SizedBox(height: 28),

              // ── LOCATION ICON ────────────────────────────────
              const Icon(Icons.location_on, size: 48, color: Colors.black87),
              const SizedBox(height: 4),
              Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),

              // ── ALAMAT TEXT ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── PETA (tap untuk buka GMaps) ──────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _openGoogleMaps,
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://staticmap.openstreetmap.de/staticmap.php'
                            '?center=$_lat,$_lng&zoom=15&size=600x400'
                            '&markers=$_lat,$_lng,red-pushpin',
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F4FD),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(Icons.map_outlined,
                                    size: 60, color: Color(0xFF2B7BB9)),
                              ),
                            ),
                          ),
                        ),

                        // Overlay tap indicator
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.open_in_new,
                                    size: 14, color: Color(0xFF2B7BB9)),
                                SizedBox(width: 4),
                                Text(
                                  'Buka Maps',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2B7BB9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── TOMBOL BUKA GMAPS ────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: _openGoogleMaps,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8C42),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF8C42).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Buka di Google Maps',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
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