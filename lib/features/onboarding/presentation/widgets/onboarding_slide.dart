
import 'package:flutter/material.dart';
import '../../data/onboarding_data.dart';

/// 🧩 Widget réutilisable pour afficher une slide d'onboarding
class OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlide slide;

  const OnboardingSlideWidget({
    super.key,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji géant
          Text(
            slide.emoji,
            style: const TextStyle(fontSize: 120),
          ),
          
          const SizedBox(height: 40),
          
          // Titre
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Description
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
