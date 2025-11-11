// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Bibliothèque'),
      ),
      body: const Center(
        child: Text(
          '🎉 Navigation depuis Splash OK !',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
