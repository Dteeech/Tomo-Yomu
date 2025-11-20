// lib/features/manga/presentation/pages/discover_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomoyomu/core/routes/app_routes.dart';
import 'package:tomoyomu/features/manga/domain/entities/manga_entity.dart';
import '../providers/discover_provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

void _navigateToDetail(BuildContext context, Manga manga) {
  Navigator.pushNamed(
    context,
    AppRoutes.mangaDetail,
    arguments: manga, // 📦 Passe l'objet complet
  );
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    // Charge les données au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiscoverProvider>().loadTopMangas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Découvrir'),
      ),
      body: Consumer<DiscoverProvider>(
        builder: (context, provider, child) {
          return CustomScrollView(
            slivers: [
              // Section 1 : Header "Recommandés"
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Recommandés pour toi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Basé sur tes goûts et notes',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Carousel horizontal (vraies données)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: _buildCarousel(provider),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Section 2 : Header "Catalogue"
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.explore,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Catalogue complet',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Liste verticale (vraies données)
              _buildCatalogList(provider),
            ],
          );
        },
      ),
    );
  }

  // 🎡 Carousel horizontal
  Widget _buildCarousel(DiscoverProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(height: 8),
            Text(provider.errorMessage!),
          ],
        ),
      );
    }

    if (!provider.hasData) {
      return const Center(child: Text('Aucun manga trouvé'));
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: provider.topMangas.take(10).length,
      itemBuilder: (context, index) {
        final manga = provider.topMangas[index];

        return GestureDetector(
          // Intercepte les taps
          onTap: () => _navigateToDetail(context, manga),

          child: Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: manga.imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(manga.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: manga.imageUrl == null ? Colors.grey[300] : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manga.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (manga.rating != null)
                    Text(
                      '⭐ ${manga.rating!.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 📋 Liste catalogue verticale
  Widget _buildCatalogList(DiscoverProvider provider) {
    if (provider.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.errorMessage != null) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(provider.errorMessage!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.loadTopMangas(),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!provider.hasData) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('Aucun manga trouvé')),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final manga = provider.topMangas[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF252541),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: manga.imageUrl != null
                      ? Image.network(
                          manga.imageUrl!,
                          width: 60,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.book, size: 48),
                        )
                      : const Icon(Icons.book, size: 48),
                ),
                title: Text(
                  manga.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: manga.rating != null
                    ? Text('⭐ ${manga.rating!.toStringAsFixed(1)}')
                    : null,
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _navigateToDetail(context, manga),
              ),
            );
          },
          childCount: provider.topMangas.length,
        ),
      ),
    );
  }
}
