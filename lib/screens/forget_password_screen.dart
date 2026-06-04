import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ══════════════════════════════════════════
// HALAMAN 1: LUPA KATA SANDI
// ══════════════════════════════════════════
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() { _emailController.dispose(); super.dispose(); }

  void _kirimKode() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap isi email kamu dulu ya!'), backgroundColor: Colors.orange));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(email: _emailController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(
      context: context,
      centerWidget: Container(width: 22, height: 36, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300))),
      title: 'Lupa kata sandi?',
      subtitle: 'Ngga usah panik, tingga isi data kamu biar\nbisa masuk lagi',
      children: [
        _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
        const SizedBox(height: 20),
        _buildButton('Kirim Kode', _isLoading, _kirimKode),
      ],
    );
  }
}

// ══════════════════════════════════════════
// HALAMAN 2: OTP 6 DIGIT
// ══════════════════════════════════════════
class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) _focusNodes[index + 1].requestFocus();
    if (value.isEmpty && index > 0) _focusNodes[index - 1].requestFocus();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _verifikasi() async {
    if (_otpCode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan 6 digit kode!'), backgroundColor: Colors.orange));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black87), onPressed: () => Navigator.pop(context))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildIllustration(centerWidget: const Text('✉️', style: TextStyle(fontSize: 30))),
                const SizedBox(height: 32),
                const Text('Cek email kamu!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text('Kode verifikasi sudah dikirim ke\n${widget.email}', style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => SizedBox(
                    width: 48, height: 56,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true, fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFF5A623), width: 2)),
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  )),
                ),
                const SizedBox(height: 20),
                Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Tidak menerima kode? ', style: TextStyle(color: Colors.black54)),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kode sudah dikirim ulang!'), backgroundColor: Colors.orange)),
                    child: const Text('Kirim ulang', style: TextStyle(color: Color(0xFFF5A623), fontWeight: FontWeight.bold)),
                  ),
                ])),
                const SizedBox(height: 28),
                _buildButton('Verifikasi', _isLoading, _verifikasi),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// HALAMAN 3: BUAT KATA SANDI BARU
// ══════════════════════════════════════════
class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirm = false;

  @override
  void dispose() { _passwordController.dispose(); _confirmController.dispose(); super.dispose(); }

  void _simpan() async {
    if (_passwordController.text.isEmpty || _confirmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap isi semua kolom!'), backgroundColor: Colors.orange));
      return;
    }
    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kata sandi minimal 6 karakter!'), backgroundColor: Colors.orange));
      return;
    }
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kata sandi tidak cocok!'), backgroundColor: Colors.red));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyNewPasswordScreen(email: widget.email, newPassword: _passwordController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(
      context: context,
      centerWidget: const Text('🔒', style: TextStyle(fontSize: 30)),
      title: 'Bikin Kata Sandi Baru',
      subtitle: 'Masukkan kata sandi baru, jangan sampai\nlupa lagi ya!',
      children: [
        _buildPasswordField(_passwordController, 'Kata sandi baru', _showPassword, () => setState(() => _showPassword = !_showPassword)),
        const SizedBox(height: 16),
        _buildPasswordField(_confirmController, 'Ulangi kata sandi baru', _showConfirm, () => setState(() => _showConfirm = !_showConfirm)),
        const SizedBox(height: 28),
        _buildButton('Simpan Kata Sandi', _isLoading, _simpan),
      ],
    );
  }
}

// ══════════════════════════════════════════
// HALAMAN 4: MASUKKAN ULANG EMAIL & SANDI
// ══════════════════════════════════════════
class VerifyNewPasswordScreen extends StatefulWidget {
  final String email;
  final String newPassword;
  const VerifyNewPasswordScreen({super.key, required this.email, required this.newPassword});
  @override
  State<VerifyNewPasswordScreen> createState() => _VerifyNewPasswordScreenState();
}

class _VerifyNewPasswordScreenState extends State<VerifyNewPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;

  @override
  void dispose() { _emailController.dispose(); _passwordController.dispose(); super.dispose(); }

  void _konfirmasi() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap isi semua kolom!'), backgroundColor: Colors.orange));
      return;
    }
    if (_emailController.text.trim() != widget.email.trim() || _passwordController.text != widget.newPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email atau kata sandi tidak cocok!'), backgroundColor: Colors.red));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordSuccessScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(
      context: context,
      centerWidget: const Text('✅', style: TextStyle(fontSize: 30)),
      title: 'Konfirmasi Akun',
      subtitle: 'Masukkan email dan kata sandi baru\nyang tadi kamu buat ya!',
      children: [
        _buildTextField(_emailController, 'Email', TextInputType.emailAddress),
        const SizedBox(height: 16),
        _buildPasswordField(_passwordController, 'Kata sandi baru', _showPassword, () => setState(() => _showPassword = !_showPassword)),
        const SizedBox(height: 28),
        _buildButton('Masuk', _isLoading, _konfirmasi),
      ],
    );
  }
}

// ══════════════════════════════════════════
// HALAMAN 5: BERHASIL
// ══════════════════════════════════════════
class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEEFF9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Ilustrasi kucing & anjing
               Container(
  width: double.infinity,
  height: 200,
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(28),
    image: const DecorationImage(
      image: AssetImage('assets/images/kucing_anjing.png'),
      fit: BoxFit.contain,
    ),
  ),
),

                const SizedBox(height: 32),

                // Teks kecil atas
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jangan Lupa Kata Sandi Lagi Ya!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Ikon centang besar
                Container(
                  width: 100, height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A5F8A),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x331A5F8A), blurRadius: 20, offset: Offset(0, 8)),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 54),
                ),

                const SizedBox(height: 24),

                // Teks utama
                const Text(
                  'Kata Sandi Anda Telah Disimpan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5F8A),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Sekarang kamu bisa masuk lagi pakai kata sandi yang baru ya!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade400, height: 1.5),
                ),

                const SizedBox(height: 48),

                // Tombol Kembali
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A623),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0x66F5A623),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Kembali ke Login',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// WIDGET HELPER
// ══════════════════════════════════════════
Scaffold _buildScaffold({
  required BuildContext context,
  required Widget centerWidget,
  required String title,
  required String subtitle,
  required List<Widget> children,
}) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black87), onPressed: () => Navigator.pop(context)),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildIllustration(centerWidget: centerWidget),
              const SizedBox(height: 32),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5)),
              const SizedBox(height: 28),
              ...children,
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildIllustration({required Widget centerWidget}) {
  return Container(
    width: double.infinity,
    height: 210,
    decoration: BoxDecoration(
      color: const Color(0xFFDEEFF9),
      borderRadius: BorderRadius.circular(28),
    ),
    child: Stack(
      children: [
        // Foto kucing di kiri
        Positioned(
          left: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              topLeft: Radius.circular(28),
            ),
            child: Image.asset(
              'assets/images/kucing.png',
              width: 130,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Foto anjing di kanan
        Positioned(
          right: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: Image.asset(
              'assets/images/anjing.png',
              width: 130,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Icon tengah
        Positioned(
          bottom: 40, left: 0, right: 0,
          child: Center(
            child: Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF5A623), width: 2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
              ),
              child: Center(child: centerWidget),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTextField(TextEditingController controller, String hint, TextInputType type) {
  return TextField(
    controller: controller, keyboardType: type,
    decoration: InputDecoration(
      hintText: hint, hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
      filled: true, fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFF5A623), width: 1.5)),
    ),
  );
}

Widget _buildPasswordField(TextEditingController controller, String hint, bool show, VoidCallback toggle) {
  return TextField(
    controller: controller, obscureText: !show,
    decoration: InputDecoration(
      hintText: hint, hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
      filled: true, fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      suffixIcon: IconButton(icon: Icon(show ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black38), onPressed: toggle),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFF5A623), width: 1.5)),
    ),
  );
}

Widget _buildButton(String label, bool isLoading, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity, height: 54,
    child: ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF5A623), foregroundColor: Colors.white, elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)
          : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    ),
  );
}

