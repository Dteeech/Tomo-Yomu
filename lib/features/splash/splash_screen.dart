// lib/features/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tomoyomu/core/routes/app_routes.dart'; // 👈 Import ajouté

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

    // Navigue vers MainNavigation après la fin de l'animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToMain();
      }
    });
  }

  void _navigateToMain() {
    // Petite pause de 500ms après la fin de l'animation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.main, // Route nommée au lieu de '/home'
        );
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
      backgroundColor: const Color(0xFF1A1A2E), 
      body: Center(
        // Centrage direct
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centre verticalement
          children: [
            Lottie.asset(
              '../../assets/animations/splash.json', //Chemin corrigé (depuis pubspec.yaml)
              controller: _controller,
              width: 200, // Dimension recommandée
              height: 200,
              fit: BoxFit.contain,
              onLoaded: (composition) {
                // Configure la durée selon l'animation
                _controller
                  ..duration = composition.duration
                  ..forward(); // ▶️ Lance l'animation
              },
            ),
            const SizedBox(
                height: 24), // 👈 Espacement entre animation et texte
            const Text(
              '友読む',
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 12, // Espacement entre caractères
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
