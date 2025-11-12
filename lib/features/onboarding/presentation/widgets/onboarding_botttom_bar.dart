
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';

/// 🧩 Barre de navigation inférieure de l'onboarding
class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSkipButton(context),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    
    // Cache le bouton sur la dernière slide
    if (provider.isLastSlide) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: () => context.read<OnboardingProvider>().skipToEnd(),
      child: const Text(
        'Passer',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return ElevatedButton(
      onPressed: () {
        if (provider.isLastSlide) {
          _navigateToHome(context);
        } else {
          context.read<OnboardingProvider>().nextPage();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        provider.isLastSlide ? 'Commencer' : 'Suivant',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    // TODO: Navigation vers HomeScreen
    Navigator.of(context).pushReplacementNamed('/main');
  }
}
