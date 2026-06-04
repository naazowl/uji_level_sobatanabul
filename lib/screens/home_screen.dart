// lib/screens/home_screen.dart

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
import 'package:app1/screens/chat_screen.dart';
import 'package:app1/screens/edit_pet_screen.dart';
import 'package:app1/screens/location_screen.dart';
import 'package:app1/screens/onboarding_screen.dart';
import 'package:app1/screens/add_pet_screen.dart';

// Import Models, Theme, Widgets & Provider
import 'package:app1/models/pet_model.dart';
import 'package:app1/models/riwayat_provider.dart';
import 'package:app1/theme/app_theme.dart';
import 'package:app1/widgets/quick_action_button.dart';
import 'package:app1/widgets/riwayat/daily_report_banner.dart';
import 'package:app1/widgets/riwayat/pet_card.dart';

class HomeScreen extends StatefulWidget {
  final String? namaAwal;
  final String? emailAwal;
  final String? usernameAwal;
  final String? teleponAwal;
  final String? imagePathAwal;

  const HomeScreen({
    super.key,
    this.namaAwal,
    this.emailAwal,
    this.usernameAwal,
    this.teleponAwal,
    this.imagePathAwal,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _namaUser;
  late String _emailUser;
  late String _usernameUser;
  late String _alamatUser;
  late String _teleponUser;
  String? _imagePathUser;

  final List<PetModel> _pets = [];
  final List<ChatMessage> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    _namaUser     = widget.namaAwal     ?? 'Naresa';
    _emailUser    = widget.emailAwal    ?? 'Naresa@gmail.com';
    _usernameUser = widget.usernameAwal ?? 'Naresarena';
    _alamatUser   = 'Kota Bogor, Indonesia';
    _teleponUser  = widget.teleponAwal  ?? '12345678910';
    _imagePathUser = widget.imagePathAwal;
  }

  Widget _buildAvatarImage() {
    if (_imagePathUser != null) {
      if (kIsWeb) {
        return Image.network(_imagePathUser!,
            width: 52, height: 52, fit: BoxFit.cover);
      } else {
        return Image.file(File(_imagePathUser!),
            width: 52, height: 52, fit: BoxFit.cover);
      }
    }
    return Image.asset(
      'assets/images/profile.jpg',
      width: 52,
      height: 52,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.person_rounded,
        size: 26,
        color: Colors.purple,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNotifications = RiwayatProvider().notifications.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── TOP BAR ───────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Notification Button
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      shadowColor: Colors.black.withOpacity(0.04),
                      elevation: 2,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationScreen(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              const Icon(Icons.notifications_none_rounded,
                                  size: 24, color: AppColors.textDark),
                              if (hasNotifications)
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Location Selector
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: Colors.black.withOpacity(0.04),
                      elevation: 2,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LocationScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  size: 16, color: AppColors.primary),
                              const SizedBox(width: 6),
                              Text(
                                _alamatUser,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 16, color: AppColors.textGrey),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Logout Button dengan Peringatan Dialog
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      shadowColor: Colors.black.withOpacity(0.04),
                      elevation: 2,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Konfirmasi Keluar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Batal',
                                      style: TextStyle(color: AppColors.textGrey),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const OnboardingScreen()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('Keluar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.logout_rounded,
                              size: 22, color: AppColors.textDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── GREETING SECTION ─────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, $_namaUser!',
                          style: const TextStyle(
                            fontSize: 26,
                            height: 1.2,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textDark,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Ayo Titipkan dan Rawat Peliharaan Anda!',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textDark.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () async {
                      final Map<String, dynamic>? dataTerbaru =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(
                            nama: _namaUser,
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
                          _namaUser     = dataTerbaru['nama']!;
                          _emailUser    = dataTerbaru['email']!;
                          _usernameUser = dataTerbaru['username']!;
                          _alamatUser   = dataTerbaru['alamat']!;
                          _teleponUser  = dataTerbaru['telepon']!;
                          _imagePathUser = dataTerbaru['imagePath'];
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: const Color(0xFFEEE0FF),
                        child: ClipOval(
                          child: _buildAvatarImage(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── QUICK ACTIONS ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuickActionButton(
                      icon: Icons.star_border_rounded,
                      label: 'Titip',
                      backgroundColor: AppColors.iconBlueBg,
                      onTap: () async {
                        final mappedPets = _pets
                            .map((pet) => {
                                  'pet': pet,
                                  'jenisHewan': pet.jenisHewan,
                                })
                            .toList();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TitipScreen(pets: mappedPets),
                          ),
                        );
                        setState(() {});
                      },
                    ),
                    QuickActionButton(
                      icon: Icons.favorite_border_rounded,
                      label: 'Info',
                      backgroundColor: AppColors.iconOrangeBg,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const InfoScreen()),
                      ),
                    ),
                    QuickActionButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Chat',
                      backgroundColor: AppColors.iconPinkBg,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(messages: _chatMessages),
                        ),
                      ),
                    ),
                    QuickActionButton(
                      icon: Icons.sync_rounded,
                      label: 'Riwayat',
                      backgroundColor: AppColors.iconYellowBg,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RiwayatScreen()),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── DAILY REPORT BANNER ───────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LaporanHarianScreen(),
                        ),
                      ),
                      child: DailyReportBanner(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── PELIHARAAN KU ─────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Peliharaan Ku',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    shadowColor: AppColors.primary.withOpacity(0.3),
                    elevation: 4,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () async {
                        final Map<String, dynamic>? result =
                            await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddPetScreen()),
                        );

                        if (result != null && result['pet'] != null) {
                          setState(() {
                            _pets.add(result['pet'] as PetModel);
                          });
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.add_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── PET CARDS ─────────────────────────────────────────────────
              SizedBox(
                height: 250,
                child: _pets.isEmpty
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.15)),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.pets_rounded,
                                  size: 36, color: Colors.grey),
                              SizedBox(height: 10),
                              Text(
                                'Belum ada peliharaan.\nKlik tombol + di atas untuk menambahkan.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  height: 1.4,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _pets.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final currentPet = _pets[index];
                          return GestureDetector(
                            onTap: () async {
                              final updatedPet = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailPetScreen(
                                    pet: currentPet,
                                    berat: currentPet.weight ?? '- kg',
                                    jenisKelamin:
                                        currentPet.gender ?? 'Jantan',
                                    catatan:
                                        currentPet.specialNotes ?? '-',
                                    ras: currentPet.breed ?? '-',
                                    jenisHewan: currentPet.jenisHewan,
                                  ),
                                ),
                              );

                              if (updatedPet != null) {
                                final result = updatedPet as Map;
                                if (result['isDeleted'] == true) {
                                  setState(() {
                                    _pets.removeAt(index);
                                  });
                                } else if (result['pet'] != null) {
                                  setState(() {
                                    _pets[index] =
                                        result['pet'] as PetModel;
                                  });
                                }
                              }
                            },
                            child: PetCard(
                              key: ValueKey(
                                  '${currentPet.name}_${currentPet.imagePath}_${currentPet.weight}'),
                              pet: currentPet,
                              berat: currentPet.weight ?? '- kg',
                              jenisKelamin: currentPet.gender ?? 'Jantan',
                              catatan: currentPet.specialNotes ?? '-',
                              ras: currentPet.breed ?? '-',
                              jenisHewan: currentPet.jenisHewan,
                              onDelete: () {
                                setState(() {
                                  _pets.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}