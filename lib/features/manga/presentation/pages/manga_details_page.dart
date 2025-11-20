// lib/presentation/pages/manga_detail_page.dart

import 'package:flutter/material.dart';
import 'package:tomoyomu/features/manga/domain/entities/manga_entity.dart';

import '../widgets/progression_slider_widget.dart';

class MangaDetailPage extends StatefulWidget {
  final Manga manga;

  const MangaDetailPage({
    super.key,
    required this.manga,
  });

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  // ═══════════════════════════════════════════════════════════
  // DONNÉES MOCKÉES (Temporaire - sera Firebase plus tard)
  // ═══════════════════════════════════════════════════════════

  int _myRating = 0; // 0 = pas encore noté
  int _currentChapter = 870;
  final int _totalChapters = 1100;
  final DateTime _startDate = DateTime(2023, 3, 15);
  final DateTime _lastRead = DateTime.now().subtract(const Duration(days: 2));
  bool _isFavorite = false;

  // ═══════════════════════════════════════════════════════════
  // BUILD PRINCIPAL
  // ═══════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D15),
      body: CustomScrollView(
        slivers: [
          _buildHeroAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTitleSection(),
                const SizedBox(height: 24),
                _buildSynopsis(),
                const SizedBox(height: 24),
                _buildMyRating(),
                const SizedBox(height: 24),
                _buildProgression(),
                const SizedBox(height: 24),
                _buildMockedStats(),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // HERO APPBAR (Image + Boutons)
  // ═══════════════════════════════════════════════════════════

  Widget _buildHeroAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: const Color(0xFF0D0D15),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
            // TODO: Sauvegarder dans Firebase
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image de fond
            Image.network(
              widget.manga.imageUrl ?? 'https://placehold.co/400',
              fit: BoxFit.cover,
            ),

            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0D0D15).withOpacity(0.7),
                    const Color(0xFF0D0D15),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // 2️⃣ SECTION TITRE (Titre + Auteur + Note + Catégories)
  // ═══════════════════════════════════════════════════════════

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titre
        Text(
          widget.manga.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // Auteur (si disponible)
        Text(
          widget.manga.author ?? 'auteur inconnu',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 16),

        // Note mondiale
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4ECDC4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              Text(
                widget.manga.rating?.toStringAsFixed(1) ?? 'N/A',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Catégories (genres)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // 🎯 SOLUTION : Utilise une liste vide par défaut
            ...(widget.manga.genres ?? []).map((genre) {
              return Chip(
                label: Text(
                  genre,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: const Color(0xFF1E1E2E),
                side: const BorderSide(color: Color(0xFF4ECDC4)),
              );
            }),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════
  // 3️⃣ SYNOPSIS
  // ═══════════════════════════════════════════════════════════

  Widget _buildSynopsis() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.manga.synopsis ?? 'Aucun synopsis disponible.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // 4️⃣ MA NOTE (5 étoiles cliquables)
  // ═══════════════════════════════════════════════════════════

  Widget _buildMyRating() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ma note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _myRating ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFFB800),
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    _myRating = index + 1;
                  });
                  // TODO: Sauvegarder dans Firebase
                },
              );
            }),
          ),
          if (_myRating > 0)
            Text(
              '$_myRating/5 étoiles',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // 5️⃣ PROGRESSION (Ton widget existant)
  // ═══════════════════════════════════════════════════════════

  Widget _buildProgression() {
    return ProgressionSliderWidget(
      currentChapter: _currentChapter,
      totalChapters: _totalChapters,
      startedDate: _startDate,
      lastReadDate: _lastRead,
      onChapterChanged: (newChapter) {
        setState(() {
          _currentChapter = newChapter;
        });
        // TODO: Sauvegarder dans Firebase
        print('✅ Chapitre mis à jour : $newChapter');
      },
    );
  }

  // ═══════════════════════════════════════════════════════════
  // 6️⃣ STATS MOCKÉES (Placeholder)
  // ═══════════════════════════════════════════════════════════

  Widget _buildMockedStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('42', 'Jours de\nlecture', const Color(0xFF4ECDC4)),
          _buildStatItem('156', 'Heures\nlues', const Color(0xFFFFB800)),
          _buildStatItem('#3', 'Top\nmondial', const Color(0xFFFF6B6B)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
