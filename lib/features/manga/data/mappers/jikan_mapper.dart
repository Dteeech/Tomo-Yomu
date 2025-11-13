import "../../domain/entities/manga_entity.dart";

class JikanMapper {
  static Manga fromJson({
    required Map<String, dynamic> json,
    required String firestoreId,
    required String scanSite,
    String? scanBaseUrl,
    MangaStatus? initialStatus,
  }) {
    return Manga(
      id: firestoreId,
      malId: json["malId"] as int,
      title: json["title"] as String,
      imageUrl: _extractImageUrl(json),
      genres: _extractGenres(json),
      synopsis: _cleanSynopsis(json["synopsis"] as String?),
      author: _extractAuthors(json),
      totalChapters: json['chapters'] as int?,
      currentChapter: null,
      status: initialStatus ?? MangaStatus.toRead,
      rating: null,
      scanSite: scanSite,
      scanBaseUrl: scanBaseUrl,
      addedAt: DateTime.now(),
      updatedAt: null,
    );
  }

  static String? _extractImageUrl(Map<String, dynamic> json) {
    final images = json["images"]?["jpg"];
    return images?['large_image_url'] ?? images?['image_url'];
  }

  static List<String> _extractGenres(Map<String, dynamic> json) {
    final rawGenres = json['genres'] as List?;
    return rawGenres
            ?.map((g) => g['name'] as String)
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];
  }

  static String? _cleanSynopsis(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    return raw.trim();
  }

  static String? _extractAuthors(Map<String, dynamic> json) {
    final authors = json['authors'] as List?;

    if (authors == null || authors.isEmpty) {
      return null;
    }

    // Extraction des noms
    final authorNames = authors
        .map((author) => author['name'] as String?)
        .where((name) => name != null && name.trim().isNotEmpty)
        .toList();

    if (authorNames.isEmpty) {
      return null;
    }

     return authorNames.join(', ');

  }
}
