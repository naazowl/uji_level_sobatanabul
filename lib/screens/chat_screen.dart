import 'package:flutter/material.dart';
import 'calling_screen.dart'; // Memastikan file CallingScreen terhubung

class ChatMessage {
  final String text;
  final bool isFromAdmin;
  final String time;

  ChatMessage({
    required this.text,
    required this.isFromAdmin,
    required this.time,
  });
}

class ChatScreen extends StatefulWidget {
  // Menampung list global yang dikirim dan dijaga oleh Homepage
  final List<ChatMessage> messages;

  const ChatScreen({super.key, required this.messages});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Nomor HP dinamis Admin SobatAnabul
  final String _adminPhone = '081234567890'; 

  @override
  void initState() {
    super.initState();
    
    // Jika riwayat pesan dari Homepage masih kosong (baru pertama kali buka chat)
    // otomatis tambahkan pesan sambutan dari Admin agar data tidak kosongan
    if (widget.messages.isEmpty) {
      widget.messages.add(
        ChatMessage(
          text: 'Halo, Kak! Selamat datang di Sobat Anabul 🐾. Admin kami akan segera membalas pesan Kakak. Ada yang bisa kami bantu?',
          isFromAdmin: true,
          time: _currentTime(),
        ),
      );
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _currentTime() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year.toString().substring(2)}';
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      // Langsung dimasukkan ke list widget.messages agar tersimpan di list aslinya Homepage
      widget.messages.add(ChatMessage(
        text: text,
        isFromAdmin: false,
        time: _currentTime(),
      ));
    });

    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  void _hapusBubble(int index) {
    // Jangan hapus pesan sambutan admin pertama (index 0)
    if (index == 0 && widget.messages[0].isFromAdmin) return;
    setState(() => widget.messages.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── HEADER ───────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFD6EFFA),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 18, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8C42),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.pets,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SobatAnabul',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                          SizedBox(height: 2),
                          Text('Admin',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    
                    // ── TOMBOL CALL ──
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallingScreen(
                              adminName: 'SobatAnabul Admin',
                              adminPhone: _adminPhone,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.call_outlined,
                            size: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── CHAT MESSAGES ─────────────────────────────────
          Expanded(
            child: widget.messages.isEmpty
                ? const Center(
                    child: Text('Belum ada pesan',
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    itemCount: widget.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Hari Ini ${_currentTime()}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      }
                      return _buildBubble(widget.messages[index - 1], index - 1);
                    },
                  ),
          ),

          // ── INPUT BAR ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Ketik Pesan Anda..',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF8C42),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMessage msg, int index) {
    final isAdmin = msg.isFromAdmin;
    final isFirstAdmin = index == 0 && isAdmin;

    return Align(
      alignment: isAdmin ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onLongPress: isFirstAdmin ? null : () => _konfirmasiHapus(index),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.72,
          ),
          decoration: BoxDecoration(
            color: isAdmin
                ? const Color(0xFFEEEEEE) // Abu-abu untuk Admin
                : const Color(0xFFD6EFFA), // Biru muda untuk User
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: Radius.circular(isAdmin ? 4 : 18),
              bottomRight: Radius.circular(isAdmin ? 18 : 4),
            ),
          ),
          child: Text(
            msg.text,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4),
          ),
        ),
      ),
    );
  }

  void _konfirmasiHapus(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Pesan',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('Hapus pesan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal',
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _hapusBubble(index);
            },
            child: const Text('Hapus',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}