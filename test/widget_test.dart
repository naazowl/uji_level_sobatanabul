import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app1/screens/home_screen.dart'; // Import HomeScreen kamu

void main() {
  testWidgets('Memastikan HomeScreen muncul dengan teks selamat datang', (WidgetTester tester) async {
    // 1. Render HomeScreen di dalam MaterialApp dummy
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // 2. Cek apakah teks "Halo, Naresa!" berhasil muncul di layar
    expect(find.text('Halo, Naresa!'), findsOneWidget);
    
    // 3. Cek apakah bagian teks Peliharaan Ku juga muncul
    expect(find.text('Peliharaan Ku'), findsOneWidget);
  });
}