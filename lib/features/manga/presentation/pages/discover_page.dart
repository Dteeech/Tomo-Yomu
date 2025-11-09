// lib/features/discover/presentation/pages/discover_page.dart

import 'package:flutter/material.dart';

/// Écran "Découvrir"
/// 
/// Affiche :
/// - Top mangas en carousel (section "Recommandés")
/// - Top mangas en liste (section "Tendances")
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🎨 AppBar (version simple pour commencer)
      appBar: AppBar(
        title: const Text('Découvrir'),
        backgroundColor: const Color(0xFF0D0D1E), // Fond de ta maquette
      ),

      // 📄 Corps de la page
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 📌 Section 1 : Recommandés
          _buildRecommendedSection(),
          
          const SizedBox(height: 32),
          
          // 📌 Section 2 : Tendances
          _buildTrendingSection(),
        ],
      ),

      // 🎨 Fond sombre
      backgroundColor: const Color(0xFF0D0D1E),
    );
  }

  // 🎯 Section "Recommandés pour toi"
  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre de section
        const Text(
          'Recommandés pour toi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 📦 Placeholder pour le carousel
        Container(
          height: 350,
          color: Colors.grey[800],
          child: const Center(
            child: Text(
              'Carousel ici (prochaine étape)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // 📊 Section "Tendances du moment"
  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre de section
        const Text(
          'Tendances du moment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 📦 Placeholder pour la liste
        Container(
          height: 400,
          color: Colors.grey[800],
          child: const Center(
            child: Text(
              'Liste ici (prochaine étape)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
