import 'dart:io'; // 💡 WAJIB: Untuk membaca berkas gambar dari File Manager HP/PC
import 'package:flutter/foundation.dart'; // 💡 WAJIB: Untuk mengecek kIsWeb (Web browser support)
import 'package:app1/screens/titip_screen.dart';
import 'package:app1/screens/notification_screen.dart';
import 'package:app1/screens/profile_screen.dart';
import 'package:app1/screens/info_screen.dart';
import 'package:app1/screens/riwayat_screen.dart'; // 💡 TAMBAHAN: Import screen riwayat
import 'package:flutter/material.dart';
import 'package:app1/models/pet_model.dart';
import 'package:app1/theme/app_theme.dart';
import 'package:app1/widgets/quick_action_button.dart';
import 'package:app1/widgets/riwayat/daily_report_banner.dart';
import 'package:app1/widgets/riwayat/pet_card.dart';
import 'package:app1/screens/laporan_harian_screen.dart'; // 💡 TAMBAHAN: Import screen laporan harian baru


// 💡 STRUKTUR MENGGUNAKAN STATEFULWIDGET UNTUK STATE MANAGEMENT LOKAL
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel penampung state data profil agar tidak ter-reset
  String _namaUser = 'Halo, Naresa!';
  String _emailUser = 'Naresa@gmail.com';
  String _usernameUser = 'Naresarena';
  String _alamatUser = 'Kota Bogor, Indonesia'; 
  String _teleponUser = '12345678910';
  String? _imagePathUser; // 💡 PERBAIKAN 1: Variabel penampung path foto profil baru

  static const List<PetModel> _pets = [
    PetModel(
      name: 'Cello',
      age: '1 Tahun',
      imagePath: 'assets/images/cello.png', 
    ),
  ];

  // 💡 PERBAIKAN 2: Fungsi pembangun Avatar agar adaptif mendukung File Gambar Baru & Web
  Widget _buildAvatarImage() {
    if (_imagePathUser != null) {
      if (kIsWeb) {
        return Image.network(_imagePathUser!, width: 52, height: 52, fit: BoxFit.cover);
      } else {
        return Image.file(File(_imagePathUser!), width: 52, height: 52, fit: BoxFit.cover);
      }
    }
    
    // Fallback jika belum pernah ganti gambar profil
    return Image.asset(
      'assets/images/profile.jpg',
      width: 52,
      height: 52,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.person,
        size: 26,
        color: Colors.purple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 💡 Jarak awal dari batas atas SafeArea disesuaikan agar lebih proporsional
              const SizedBox(height: 24),

              // ── TOP BAR (Notification, Location, Logout) ───────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 12), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Bell icon
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications_outlined, size: 28),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Location
                    Padding(
                      padding: const EdgeInsets.only(top: 5), 
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, size: 18, color: AppColors.textDark),
                          const SizedBox(width: 10),
                          Text(
                            _alamatUser,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Logout icon
                    const Icon(Icons.logout, size: 26),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // ── Greeting Section ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _namaUser.startsWith('Halo,') ? _namaUser : 'Halo, $_namaUser!', 
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ayo Titipkan dan Rawat Peliharaan Anda!',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  // Avatar Profil
                  GestureDetector(
                    onTap: () async {
                      // 💡 PERBAIKAN 3: Mengubah tipe kembalian data menjadi Map<String, dynamic>? agar tidak error
                      final Map<String, dynamic>? dataTerbaru = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            nama: _namaUser.replaceAll('Halo, ', '').replaceAll('!', ''),
                            email: _emailUser,
                            username: _usernameUser,
                            alamat: _alamatUser,
                            telepon: _teleponUser,
                            currentImagePath: _imagePathUser, // 💡 Kirim data path foto yang sekarang ke screen profile
                          ),
                        ),
                      );

                      if (dataTerbaru != null) {
                        setState(() {
                          _namaUser = dataTerbaru['nama']!;
                          _emailUser = dataTerbaru['email']!;
                          _usernameUser = dataTerbaru['username']!;
                          _alamatUser = dataTerbaru['alamat']!;
                          _teleponUser = dataTerbaru['telepon']!;
                          _imagePathUser = dataTerbaru['imagePath']; // 💡 PERBAIKAN 4: Ambil path file baru dari profile_screen
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 26, // Sedikit diperbesar agar seimbang dengan layout baru
                      backgroundColor: const Color(0xFFEEE0FF),
                      child: ClipOval(
                        child: _buildAvatarImage(), // 💡 PERBAIKAN 5: Menggunakan fungsi penampil gambar adaptif
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // ── Quick Actions ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuickActionButton(
                    icon: Icons.star_border_rounded,
                    label: 'Titip',
                    backgroundColor: AppColors.iconBlueBg,
                    onTap: () {
                      // Mengubah List<PetModel> menjadi List<Map<String, dynamic>> sesuai kebutuhan TitipScreen
                      final mappedPets = _pets.map((pet) => {
                        'pet': pet,
                        'jenisHewan': 'Anjing', // Nilai default jenis hewan
                      }).toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TitipScreen(pets: mappedPets),
                        ),
                      );
                    },
                  ),
                  QuickActionButton(
                    icon: Icons.favorite_border_rounded,
                    label: 'Info',
                    backgroundColor: AppColors.iconOrangeBg,
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InfoScreen())),
                  ),
                  QuickActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Chat',
                    backgroundColor: AppColors.iconPinkBg,
                  ),
                  QuickActionButton(
                    icon: Icons.sync_rounded,
                    label: 'Riwayat',
                    backgroundColor: AppColors.iconYellowBg,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RiwayatScreen()),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // ── Daily Report Banner ───────────────────────────
              // 💡 TAMBAHAN: Dibungkus dengan GestureDetector agar bisa diklik menuju LaporanHarianScreen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LaporanHarianScreen(),
                    ),
                  );
                },
                child: DailyReportBanner(),
              ),

              const SizedBox(height: 36),

              // ── Section Title: Peliharaan Ku ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Peliharaan Ku',
                    style: TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ── Pet Cards Horizontal List ─────────────────────
              SizedBox(
                height: 240, 
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _pets.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => PetCard(pet: _pets[index]),
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