import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/pet_model.dart';
import 'package:app1/screens/edit_pet_screen.dart';

class PetCard extends StatelessWidget {
  final PetModel pet;

  const PetCard({super.key, required this.pet});

  Widget _buildPetImage() {
    if (pet.isLocalFile ?? false) {
      if (kIsWeb) {
        return Image.network(pet.imagePath, fit: BoxFit.cover);
      } else {
        return Image.file(File(pet.imagePath), fit: BoxFit.cover);
      }
    }
    return Image.asset(
      pet.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 40, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 220, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(
            height: 150, 
            width: double.infinity, 
            decoration: const BoxDecoration(
              color: Color(0xFFDBEFF8), 
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)), 
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: _buildPetImage(), 
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(height: 4),
                Text(
                  pet.age,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── DETAIL PET SCREEN (STATEFUL AGAR DI-REFRESH REALTIME) ──
class DetailPetScreen extends StatefulWidget {
  final PetModel pet;

  const DetailPetScreen({super.key, required this.pet});

  @override
  State<DetailPetScreen> createState() => _DetailPetScreenState();
}

class _DetailPetScreenState extends State<DetailPetScreen> {
  late PetModel _currentPet;

  @override
  void initState() {
    super.initState();
    _currentPet = widget.pet;
  }

  Widget _buildDetailAvatar() {
    if (_currentPet.isLocalFile ?? false) {
      if (kIsWeb) {
        return Image.network(_currentPet.imagePath, fit: BoxFit.cover);
      } else {
        return Image.file(File(_currentPet.imagePath), fit: BoxFit.cover);
      }
    }
    return Image.asset(
      _currentPet.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.pets, size: 60, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEFF8),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(120)),
                  ),
                ),
                Positioned(
                  top: 0, left: 0, right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
                              onPressed: () => Navigator.pop(context, _currentPet), // Lempar objek baru ke Home
                            ),
                          ),
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
                            child: const Icon(Icons.more_horiz, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: 200, height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFDBEFF8),
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    child: ClipOval(child: _buildDetailAvatar()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              _currentPet.name, 
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoBox(_currentPet.age, 'Umur'), 
                  _buildInfoBox(_currentPet.weight ?? '-', 'Berat'), 
                  _buildInfoBox(_currentPet.gender ?? '-', 'Jenis\nKelamin'), 
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Catatan Khusus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
                  const SizedBox(height: 16),
                  _buildNoteTile(
                    icon: Icons.format_list_bulleted_rounded,
                    text: _currentPet.specialNotes ?? 'Tidak ada catatan khusus', 
                    bgColor: const Color(0xFFFDE8D7),
                    iconBgColor: const Color(0xFFFF8C42),
                  ),
                  const SizedBox(height: 12),
                  _buildNoteTile(
                    icon: Icons.edit_rounded,
                    text: 'Edit data hewan',
                    bgColor: const Color(0xFFE0D9FF),
                    iconBgColor: const Color(0xFF7C5CFC),
                    onTap: () async {
                      // Ambil Map kiriman EditPetScreen
                      final Map<String, dynamic>? hasilEdit = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPetScreen(pet: _currentPet)),
                      );

                      if (hasilEdit != null && hasilEdit['pet'] != null) {
                        setState(() {
                          _currentPet = hasilEdit['pet'] as PetModel;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFDBEFF8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Text(value, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1A1A1A))),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF6F777A), fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteTile({
    required IconData icon,
    required String text,
    required Color bgColor,
    required Color iconBgColor,
    VoidCallback? onTap, 
  }) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
            ),
          ],
        ),
      ),
    );
  }
}