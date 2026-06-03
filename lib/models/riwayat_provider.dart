// lib/models/riwayat_provider.dart

enum StatusTitipan { menunggu, sedangDititip, selesai }

class RiwayatItem {
  final String id;
  final String petName;
  final String petType;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final List<Map<String, dynamic>> selectedCategories;
  final int grandTotal;
  final String metodePembayaran;
  final DateTime createdAt;

  RiwayatItem({
    required this.id,
    required this.petName,
    required this.petType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.selectedCategories,
    required this.grandTotal,
    required this.metodePembayaran,
    required this.createdAt,
  });

  StatusTitipan get status {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    if (today.isBefore(start)) return StatusTitipan.menunggu;
    if (today.isAfter(end)) return StatusTitipan.selesai;
    return StatusTitipan.sedangDititip;
  }
}

class RiwayatProvider {
  static final RiwayatProvider _instance = RiwayatProvider._internal();
  factory RiwayatProvider() => _instance;
  RiwayatProvider._internal();

  // ── RIWAYAT TITIPAN ──────────────────────────────────────────────────────────
  final List<RiwayatItem> _items = [];

  List<RiwayatItem> get items =>
      List.unmodifiable(_items.reversed.toList());

  void tambah(RiwayatItem item) => _items.add(item);
  void hapus(String id) => _items.removeWhere((e) => e.id == id);
  void hapusSemua() => _items.clear();

  // ── NOTIFIKASI ───────────────────────────────────────────────────────────────
  final List<Map<String, String>> _notifications = [];

  /// Mengembalikan daftar notifikasi terbaru di urutan paling atas.
  List<Map<String, String>> get notifications =>
      List.unmodifiable(_notifications.reversed.toList());

  /// Tambah satu notifikasi baru.
  void tambahNotifikasi(Map<String, String> notif) =>
      _notifications.add(notif);

  /// Hapus notifikasi berdasarkan id.
  void hapusNotifikasi(String id) =>
      _notifications.removeWhere((e) => e['id'] == id);

  /// Hapus semua notifikasi sekaligus.
  void hapusSemuaNotifikasi() => _notifications.clear();

  // ── LAPORAN HARIAN ───────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _laporanList = [];

  /// Mengembalikan daftar laporan, terbaru di urutan paling atas.
  List<Map<String, dynamic>> get laporanList =>
      List.unmodifiable(_laporanList.reversed.toList());

  /// Tambah laporan harian baru ketika penitipan berhasil dibuat.
  void tambahLaporan(Map<String, dynamic> laporan) =>
      _laporanList.add(laporan);
}