// lib/screens/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:app1/models/riwayat_provider.dart';
import 'laporan_harian_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isExpanded = false;

  // Ambil data LANGSUNG dari singleton RiwayatProvider — tidak ada hardcode.
  List<Map<String, String>> get _allNotifications =>
      RiwayatProvider().notifications.cast<Map<String, String>>();

  @override
  Widget build(BuildContext context) {
    final displayedNotifications =
        _isExpanded ? _allNotifications : _allNotifications.take(3).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ── TOP BAR ──────────────────────────────────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Notifikasi',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Tombol hapus semua — hanya muncul jika ada notifikasi
                  if (_allNotifications.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        RiwayatProvider().hapusSemuaNotifikasi();
                        setState(() {});
                      },
                      child: const Text(
                        'Hapus Semua',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── DAFTAR NOTIFIKASI / EMPTY STATE ─────────────────────────────────
            Expanded(
              child: _allNotifications.isEmpty
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          ...displayedNotifications.map((notif) {
                            return Dismissible(
                              key: Key(notif['id']!),
                              direction: DismissDirection.endToStart,
                              background: _buildDismissBackground(),
                              onDismissed: (direction) {
                                RiwayatProvider()
                                    .hapusNotifikasi(notif['id']!);
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Notifikasi dihapus'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LaporanHarianScreen(),
                                    ),
                                  );
                                },
                                child: _buildNotificationCard(
                                  notif['title'] ?? '',
                                  notif['time'] ?? '',
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 12),

                          // Tombol expand — hanya tampil jika item > 3
                          if (_allNotifications.length > 3)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Icon(
                                  _isExpanded
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  size: 32,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
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

  Widget _buildDismissBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.delete_sweep_rounded,
        color: Colors.red.shade400,
        size: 28,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 38,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada notifikasi baru',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Notifikasi akan muncul setelah penitipan dilakukan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(String title, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFF5F5F5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF2E6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pets_rounded,
                color: Color(0xFFFF9933),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}