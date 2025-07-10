import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uasdika01/main.dart';

void main() {
  testWidgets('Menampilkan halaman Daftar User', (WidgetTester tester) async {
    // Menjalankan aplikasi
    await tester.pumpWidget(MyApp());

    // Tunggu sampai semua frame selesai
    await tester.pumpAndSettle();

    // Pastikan AppBar/h1 menampilkan teks "Daftar User"
    expect(find.text('Daftar User'), findsOneWidget);

    // Pastikan ada ListView yang memuat user
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman Profil', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    // Tap ikon profil (icon di BottomNavigationBar kedua)
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Pastikan halaman profil ditampilkan (cek salah satu teksnya)
    expect(find.text('Nama:'), findsOneWidget);
  });
}
