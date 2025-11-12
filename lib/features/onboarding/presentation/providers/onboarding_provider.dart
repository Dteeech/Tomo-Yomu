// lib/features/onboarding/presentation/providers/onboarding_provider.dart

import 'package:flutter/material.dart';
import '../../data/onboarding_data.dart';

/// Provider gérant l'état et la logique de l'onboarding
///
/// Responsabilités :
/// - Gestion du PageController
/// - Tracking de la page actuelle
/// - Navigation entre slides
/// - Détection de la dernière slide
class OnboardingProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// Controller pour le PageView
  PageController get pageController => _pageController;

  /// Index de la page actuelle (0-based)
  int get currentPage => _currentPage;

  /// Total de slides
  int get totalPages => onboardingSlides.length;

  /// Vérifie si on est sur la dernière slide
  bool get isLastSlide => onboardingSlides[_currentPage].isLastSlide;

  /// Texte du bouton (Suivant ou custom)
  String get buttonText =>
      onboardingSlides[_currentPage].buttonText ?? 'Suivant';
  
  /// Met à jour la page actuelle (appelé par PageView.onPageChanged)
  void updatePage(int page) {
    _currentPage = page;
    notifyListeners(); // Notifie l'UI du changement
  }

  
  void nextPage() {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }


  void skipToEnd() {
    _pageController.animateToPage(
      totalPages - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    _pageController.dispose(); // Libère les ressources
    super.dispose();
  }
}
