import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Import Screens
import 'package:app1/screens/titip_screen.dart';
import 'package:app1/screens/notification_screen.dart';
import 'package:app1/screens/profile_screen.dart';
import 'package:app1/screens/info_screen.dart';
import 'package:app1/screens/riwayat_screen.dart';
import 'package:app1/screens/laporan_harian_screen.dart';
import 'package:app1/screens/calling_screen.dart';
import 'package:app1/screens/chat_screen.dart';
import 'package:app1/screens/edit_pet_screen.dart';
import 'package:app1/screens/location_screen.dart';
import 'package:app1/screens/onboarding_screen.dart';
import 'package:app1/screens/splash_screen.dart';
import 'package:app1/screens/add_pet_screen.dart';

// Import Models, Theme, & Widgets
import 'package:app1/models/pet_model.dart';
import 'package:app1/theme/app_theme.dart';
import 'package:app1/widgets/quick_action_button.dart';
import 'package:app1/widgets/riwayat/daily_report_banner.dart';
import 'package:app1/widgets/riwayat/pet_card.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _namaUser = 'Halo, Naresa!';
  String _emailUser = 'Naresa@gmail.com';
  String _usernameUser = 'Naresarena';
  String _alamatUser = 'Kota Bogor, Indonesia';
  String _teleponUser = '12345678910';
  String? _imagePathUser;

  // List dinamis kosong untuk Peliharaan
  List<PetModel> _pets = [];

  // 🟢 PERBAIKAN: Memastikan list dideklarasikan sebagai growable secara eksplisit untuk Web platform
  final List<ChatMessage> _riwayatChat = List<ChatMessage>.empty(growable: true);

  Widget _buildAvatarImage() {
    if (_imagePathUser != null) {
      if (kIsWeb) {
        return Image.network(_imagePathUser!, width: 52, height: 52, fit: BoxFit.cover);
      } else {
        return Image.file(File(_imagePathUser!), width: 52, height: 52, fit: BoxFit.cover);
      }
    }
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
              const SizedBox(height: 24),

              // ── TOP BAR (Notification, Location, Logout) ───────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationScreen()),
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

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LocationScreen()),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, size: 18, color: AppColors.textDark),
                            const SizedBox(width: 10),
                            Text(
                              _alamatUser,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                          (route) => false,
                        );
                      },
                      child: const Icon(Icons.logout, size: 26),
                    ),
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
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ayo Titipkan dan Rawat Peliharaan Anda!',
                        style: TextStyle(fontSize: 13, color: AppColors.textGrey, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () async {
                      final Map<String, dynamic>? dataTerbaru = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            nama: _namaUser.replaceAll('Halo, ', '').replaceAll('!', ''),
                            email: _emailUser,
                            username: _usernameUser,
                            alamat: _alamatUser,
                            telepon: _teleponUser,
                            currentImagePath: _imagePathUser,
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
                          _imagePathUser = dataTerbaru['imagePath'];
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFFEEE0FF),
                      child: ClipOval(child: _buildAvatarImage()),
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
                      final mappedPets = _pets.map((pet) => {
                        'pet': pet,
                        'jenisHewan': 'Anjing',
                      }).toList();
                      Navigator.push(
                        context,
                        // 🟢 PERBAIKAN: Menghapus typo 'mappedMappedPets'
                        MaterialPageRoute(builder: (context) => TitipScreen(pets: mappedPets)),
                      );
                    },
                  ),
                  QuickActionButton(
                    icon: Icons.favorite_border_rounded,
                    label: 'Info',
                    backgroundColor: AppColors.iconOrangeBg,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InfoScreen())),
                  ),
                  
                  QuickActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Chat',
                    backgroundColor: AppColors.iconPinkBg,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(messages: _riwayatChat),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                  
                  QuickActionButton(
                    icon: Icons.sync_rounded,
                    label: 'Riwayat',
                    backgroundColor: AppColors.iconYellowBg,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatScreen())),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // ── Daily Report Banner ───────────────────────────
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LaporanHarianScreen()));
                },
                child: DailyReportBanner(),
              ),

              const SizedBox(height: 36),

              // ── Section Title: Peliharaan Ku (Tombol Tambah) ─────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Peliharaan Ku',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Map<String, dynamic>? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddPetScreen()),
                      );

                      if (result != null && result['pet'] != null) {
                        setState(() {
                          _pets.add(result['pet'] as PetModel);
                        });
                      }
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // ── AREA LIST KARTU ANABUL ──
              SizedBox(
                height: 240,
                child: _pets.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada peliharaan.\nKlik tombol + untuk menambahkan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _pets.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              final updatedPet = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPetScreen(pet: _pets[index]),
                                ),
                              );

                              if (updatedPet != null && updatedPet is PetModel) {
                                setState(() {
                                  _pets[index] = updatedPet;
                                });
                              }
                            },
                            child: PetCard(
                              key: ValueKey('${_pets[index].name}_${_pets[index].age}'),
                              pet: _pets[index],
                            ),
                          );
                        },
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