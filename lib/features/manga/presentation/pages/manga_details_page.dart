import 'package:flutter/material.dart';
import '../../domain/entities/manga_entity.dart';

class MangaDetailsPage extends StatelessWidget {
  final Manga manga;

  const MangaDetailsPage({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(manga.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (manga.imageUrl != null) Image.network(manga.imageUrl!),
            const SizedBox(height: 12),
            Text('Genres: ${manga.genres.join(', ')}'),
            const SizedBox(height: 8),
            Text('Status: ${manga.status.toString().split('.').last}'),
            const SizedBox(height: 8),
            if (manga.synopsis != null) Text(manga.synopsis!),
          ],
        ),
      ),
    );
  }
}
