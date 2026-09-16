import 'package:flutter/material.dart';
import 'halaman.dart';

void main() {
  runApp(const KopdesApp());
}

class KopdesApp extends StatelessWidget {
  const KopdesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KOPDES',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F8F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HalamanUtama(),
    );
  }
}