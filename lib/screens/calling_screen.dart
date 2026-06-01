import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallingScreen extends StatefulWidget {
  final String adminName;
  final String adminPhone; // Menambahkan variabel dinamis untuk nomor HP Admin

  const CallingScreen({
    super.key, 
    this.adminName = 'SobatAnabul Admin',
    this.adminPhone = '081234567890', // Default nomor HP dummy admin
  });

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    // Otomatis melakukan panggilan telepon saat screen dibuka
    _makePhoneCall();
  }

  // Fungsi Inti untuk Menjalankan Fitur Call via URL Launcher
  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: widget.adminPhone,
    );
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        _showErrorSnackBar('Tidak dapat membuka dialer telepon.');
      }
    } catch (e) {
      _showErrorSnackBar('Terjadi kesalahan saat memproses panggilan.');
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7FC), 
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450), 
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header Atas (Nama & Status)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      widget.adminName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E5D88),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Menghubungkan ke Seluler...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Lingkaran Logo Paw Tengah
                Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBD4), 
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.pets, 
                      size: 80,
                      color: Color(0xFFFF9F29), 
                    ),
                  ),
                ),

                // Baris Tombol Kontrol Panggilan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol Hubungi Ulang jika dialer tertutup secara tidak sengaja
                    _buildCircleButton(
                      icon: Icons.call,
                      color: Colors.white,
                      iconColor: const Color(0xFF2B7BB9),
                      onTap: _makePhoneCall,
                    ),

                    // Tombol Tutup Telpon (Kembali ke halaman chat sebelumnya)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); 
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF4D4D), 
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),

                    // Tombol Mute Tiruan (Status UX UI)
                    _buildCircleButton(
                      icon: isMuted ? Icons.mic_off : Icons.mic,
                      color: isMuted ? Colors.grey : Colors.white,
                      iconColor: isMuted ? Colors.white : Colors.black54,
                      onTap: () {
                        setState(() {
                          isMuted = !isMuted;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}