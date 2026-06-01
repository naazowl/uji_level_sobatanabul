import 'package:flutter/material.dart';
import 'package:app1/screens/perawatan2_screen.dart';

class TitipCalendarScreen extends StatefulWidget {
  final String petName;
  final String petType;

  const TitipCalendarScreen({
    super.key,
    required this.petName,
    required this.petType,
  });

  @override
  State<TitipCalendarScreen> createState() => _TitipCalendarScreenState();
}

class _TitipCalendarScreenState extends State<TitipCalendarScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

  static const int _maxDays = 7;
  static const Color _primaryOrange = Color(0xFFFF8C42);
  static const Color _lightOrange = Color(0xFFFFF3EB);

  final List<String> _monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  final List<String> _dayNames = ['Sen', 'Sel', 'Ra', 'Ka', 'Ju', 'Sa', 'Mi'];

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  void _onDayTapped(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    if (date.isBefore(todayOnly)) return;

    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        // Reset, pilih tanggal mulai baru
        _startDate = date;
        _endDate = null;
      } else {
        if (date.isBefore(_startDate!)) {
          // Kalau pilih sebelum start, jadikan start baru
          _startDate = date;
          _endDate = null;
        } else if (date == _startDate) {
          // Klik start lagi = reset
          _startDate = null;
          _endDate = null;
        } else {
          // diff = jumlah hari antara start dan end (inklusif = diff + 1)
          final diff = date.difference(_startDate!).inDays;
          // Maksimal 7 hari inklusif = diff maksimal 6
          if (diff >= _maxDays) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Maksimal penitipan 7 hari'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            _endDate = date;
          }
        }
      }
    });
  }

  bool _isInRange(DateTime date) {
    if (_startDate == null || _endDate == null) return false;
    return date.isAfter(_startDate!) && date.isBefore(_endDate!);
  }

  bool _isStartDate(DateTime date) {
    if (_startDate == null) return false;
    return date.year == _startDate!.year &&
        date.month == _startDate!.month &&
        date.day == _startDate!.day;
  }

  bool _isEndDate(DateTime date) {
    if (_endDate == null) return false;
    return date.year == _endDate!.year &&
        date.month == _endDate!.month &&
        date.day == _endDate!.day;
  }

  bool _isPastDate(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    return date.isBefore(todayOnly);
  }

  List<DateTime?> _buildCalendarDays() {
    final firstDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    int startWeekday = firstDayOfMonth.weekday - 1; // Senin = 0

    final daysInMonth =
        DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final List<DateTime?> days = [];

    // Hari dari bulan sebelumnya
    for (int i = 0; i < startWeekday; i++) {
      final prevMonth =
          DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      final daysInPrev =
          DateUtils.getDaysInMonth(prevMonth.year, prevMonth.month);
      days.add(DateTime(
          prevMonth.year, prevMonth.month, daysInPrev - startWeekday + i + 1));
    }

    // Hari bulan ini
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_focusedMonth.year, _focusedMonth.month, i));
    }

    // Hari dari bulan depan untuk genapi baris
    int remaining = 7 - (days.length % 7);
    if (remaining < 7) {
      for (int i = 1; i <= remaining; i++) {
        days.add(DateTime(_focusedMonth.year, _focusedMonth.month + 1, i));
      }
    }

    return days;
  }

  bool _isCurrentMonth(DateTime date) {
    return date.month == _focusedMonth.month &&
        date.year == _focusedMonth.year;
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
  }

  int get _selectedDays {
    if (_startDate == null || _endDate == null) return 0;
    return _endDate!.difference(_startDate!).inDays + 1;
  }

  void _onSelesai() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal mulai dan selesai penitipan'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PerawatanScreen(
          petName: widget.petName,
          petType: widget.petType,
          startDate: _startDate!,
          endDate: _endDate!,
          totalDays: _selectedDays,
        ),
      ),
    ).then((v) { if (v != null) Navigator.pop(context, v); });
  }

  @override
  Widget build(BuildContext context) {
    final calendarDays = _buildCalendarDays();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      '"Buat Jadwal"',
                      style: TextStyle(
                        color: _primaryOrange,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMonthNavigator(),
                          const Divider(height: 1, thickness: 1,
                              color: Color(0xFFEEEEEE)),
                          _buildDayHeaders(),
                          _buildCalendarGrid(calendarDays),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, bottom: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '*Maksimal penitipan 7 hari',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_startDate != null) _buildSelectedInfo(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(color: Color(0xFFD6EAF8)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Titip',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildMonthNavigator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _previousMonth,
            child: const Icon(Icons.chevron_left, size: 28),
          ),
          Text(
            '${_monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: _nextMonth,
            child: const Icon(Icons.chevron_right, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeaders() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _dayNames
            .map((day) => SizedBox(
                  width: 36,
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid(List<DateTime?> days) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final date = days[index];
          if (date == null) return const SizedBox();

          final isCurrent = _isCurrentMonth(date);
          final isPast = _isPastDate(date);
          final isStart = _isStartDate(date);
          final isEnd = _isEndDate(date);
          final inRange = _isInRange(date);

          Color textColor = isCurrent ? Colors.black87 : Colors.black26;
          FontWeight fontWeight = FontWeight.normal;
          Color bgColor = Colors.transparent;

          // Past dates — tampil tapi tidak bisa dipilih
          if (isPast && isCurrent) {
            textColor = Colors.black26;
          }

          if (isStart || isEnd) {
            bgColor = _primaryOrange;
            textColor = Colors.white;
            fontWeight = FontWeight.bold;
          } else if (inRange) {
            bgColor = _lightOrange;
            textColor = _primaryOrange;
            fontWeight = FontWeight.w500;
          }

          // Semua tanggal bisa ditap (termasuk luar bulan),
          // tapi _onDayTapped akan abaikan past dates
          return GestureDetector(
            onTap: () => _onDayTapped(date),
            child: Container(
              decoration: BoxDecoration(
                color: inRange && !isStart && !isEnd
                    ? _lightOrange
                    : Colors.transparent,
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      fontWeight: fontWeight,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _primaryOrange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pets, size: 16, color: _primaryOrange),
              const SizedBox(width: 6),
              Text(
                widget.petName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: _primaryOrange),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text('Mulai: ${_formatDate(_startDate!)}',
                  style: const TextStyle(fontSize: 13)),
            ],
          ),
          if (_endDate != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Selesai: ${_formatDate(_endDate!)}',
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.timelapse, size: 14, color: _primaryOrange),
                const SizedBox(width: 6),
                Text(
                  'Total: $_selectedDays hari',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _primaryOrange,
                  ),
                ),
              ],
            ),
          ] else
            const Text(
              'Pilih tanggal selesai penitipan',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFF5F0EB),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onSelesai,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            elevation: 0,
          ),
          child: const Text(
            'Selesai',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}