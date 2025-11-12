// lib/features/onboarding/data/onboarding_data.dart

class OnboardingSlide {
  final String emoji;
  final String title;
  final String description;
  final String? buttonText;
  final bool isLastSlide;

  const OnboardingSlide({
    required this.emoji,
    required this.title,
    required this.description,
    this.buttonText,
    this.isLastSlide = false,
  });
}

// Données statiques
final List<OnboardingSlide> onboardingSlides = [
  const OnboardingSlide(
    emoji: '😰',
    title: 'Trop de mangas, tu oublies où tu en es ?',
    description: 'Entre les sorties hebdomadaires et ta pile à lire, '
        'difficile de tout suivre...',
  ),
  const OnboardingSlide(
    emoji: '⭐',
    title: 'Note et organise tes lectures',
    description: 'Partage tes coups de cœur et découvre '
        'ce que la communauté aime',
  ),
  const OnboardingSlide(
    emoji: '📖',
    title: 'Suis ta progression chapitre par chapitre',
    description: 'Ne perds plus jamais ta progression, '
        'reprends là où tu t\'es arrêté',
  ),
  const OnboardingSlide(
    emoji: '📚',
    title: 'Crée ta bibliothèque personnelle',
    description: 'Regroupe tous tes mangas au même endroit '
        'avec une recherche intelligente',
  ),
  const OnboardingSlide(
    emoji: '🚀',
    title: 'Commence maintenant !',
    description: 'Rejoins des milliers de lecteurs '
        'passionnés sur TomoYomu',
    buttonText: 'Commencer l\'aventure',
    isLastSlide: true,
  ),
];
