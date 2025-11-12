

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomoyomu/features/onboarding/presentation/widgets/onboarding_header.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_slide.dart';
import '../widgets/page_indicator.dart';
import '../widgets/onboarding_botttom_bar.dart';
import '../../data/onboarding_data.dart';

/// 🎭 Écran d'onboarding (orchestrateur)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            //import du header
            const OnboardingHeader(),
            // Zone de contenu (PageView)
            Expanded(
              child: PageView.builder(
                controller: provider.pageController,
                onPageChanged: provider.updatePage,
                itemCount: onboardingSlides.length,
                itemBuilder: (context, index) {
                  // Widget extrait = lisibilité
                  return OnboardingSlideWidget(
                    slide: onboardingSlides[index],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Indicateurs (dots)
            PageIndicator(
              totalPages: onboardingSlides.length,
              currentPage: provider.currentPage,
            ),

            const SizedBox(height: 20),

            // Barre de navigation
            const OnboardingBottomBar(),
          ],
        ),
      ),
    );
  }
}
