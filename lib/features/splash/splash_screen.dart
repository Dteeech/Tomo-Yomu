// lib/features/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Configure le contrôleur d'animation
    _controller = AnimationController(vsync: this);

    // Navigue vers Home après la fin de l'animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    // Petite pause de 500ms après la fin de l'animation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // 🎨 Bleu nuit
      body: Column(
        children: [
          Center(
            child: Lottie.asset(
              '../../../assets/animations/splash.json',
              controller: _controller,
              onLoaded: (composition) {
                // Configure la durée selon l'animation
                _controller
                  ..duration = composition.duration
                  ..forward(); // ▶️ Lance l'animation
              },
            ),
          ),
          const Text(
            '友読む',
            style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 12, // Espacement entre caractères
              height: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
