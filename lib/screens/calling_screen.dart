import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class CallingScreen extends StatefulWidget {
  final String adminName;
  final String adminPhone;

  const CallingScreen({
    super.key,
    this.adminName = 'SobatAnabul Admin',
    this.adminPhone = '081234567890',
  });

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool _sudahDitelepon = false;

  @override
  void initState() {
    super.initState();
    // Di web, tunjukkan dialog konfirmasi dulu sebelum buka dialer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kIsWeb) {
        _showKonfirmasiCall();
      } else {
        _makePhoneCall();
      }
    });
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: widget.adminPhone);
    try {
      // Di web, canLaunchUrl untuk tel: sering return false — langsung launch saja
      await launchUrl(launchUri);
      setState(() => _sudahDitelepon = true);
    } catch (e) {
      _showErrorSnackBar('Tidak dapat membuka dialer telepon.');
    }
  }

  void _showKonfirmasiCall() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C42),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Text('Hubungi Admin',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nomor Admin SobatAnabul:',
                style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  widget.adminPhone,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.adminPhone));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nomor disalin ke clipboard'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Icon(Icons.copy, size: 18, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Browser akan meminta kamu memilih aplikasi telepon. Pilih aplikasi yang sesuai.',
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _makePhoneCall();
            },
            icon: const Icon(Icons.call, size: 16),
            label: const Text('Hubungi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C42),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message), backgroundColor: Colors.redAccent),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ── Header Atas ──────────────────────────────
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
                    Text(
                      _sudahDitelepon
                          ? 'Menghubungkan ke Seluler...'
                          : 'Tap tombol panggil untuk menghubungi',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Tampilkan nomor HP & tombol salin ──
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.adminPhone));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Nomor disalin ke clipboard'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.phone,
                                size: 16, color: Color(0xFF2B7BB9)),
                            const SizedBox(width: 8),
                            Text(
                              widget.adminPhone,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.copy,
                                size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Lingkaran Logo Paw ──────────────────────
                Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBD4),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.pets, size: 80, color: Color(0xFFFF9F29)),
                  ),
                ),

                // ── Tombol Kontrol ──────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol Loud Speaker
                    _buildCircleButton(
                      icon: isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                      color: isSpeakerOn ? const Color(0xFFD6EFFA) : Colors.white,
                      iconColor: isSpeakerOn ? const Color(0xFF2B7BB9) : Colors.black54,
                      onTap: () => setState(() => isSpeakerOn = !isSpeakerOn),
                    ),

                    // Tombol Tutup / Kembali
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                        child: const Icon(Icons.call_end,
                            color: Colors.white, size: 30),
                      ),
                    ),

                    // Tombol Mute
                    _buildCircleButton(
                      icon: isMuted ? Icons.mic_off : Icons.mic,
                      color: isMuted ? Colors.grey : Colors.white,
                      iconColor: isMuted ? Colors.white : Colors.black54,
                      onTap: () => setState(() => isMuted = !isMuted),
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