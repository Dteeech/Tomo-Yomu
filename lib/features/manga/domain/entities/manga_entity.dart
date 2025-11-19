// lib/features/manga/domain/entities/manga.dart

// import 'package:cloud_firestore/cloud_firestore.dart';

enum MangaStatus { inProgress, done, toRead, abandoned }

class Manga {
  final String? id;
  final int malId;
  final String title;
  final String? imageUrl;
  final List<String> genres;
  final String? synopsis;
  final String? author;
  final int? totalChapters;
  final int? currentChapter;
  final MangaStatus status;
  final double? rating;
  final String? scanSite;
  final String? scanBaseUrl;
  final DateTime addedAt; // Type Dart
  final DateTime? updatedAt; // Type Dart

  Manga({
    required this.id,
    required this.malId,
    required this.title,
    this.imageUrl,
    required this.genres,
    this.synopsis,
    this.author,
    this.totalChapters,
    this.currentChapter,
    required this.status,
    this.rating,
    this.scanSite,
    this.scanBaseUrl,
    required this.addedAt,
    this.updatedAt,
  });

  // DEPUIS API JIKAN

  factory Manga.fromJikanApi({
    required Map<String, dynamic> json,
    required String? firestoreId,
    required String? scanSite,
    required String? scanBaseUrl,
    required MangaStatus? initialStatus,
  }) {
    // Extraction image URL (priorité large > default)
    final images = json['images']?['jpg'];
    final imageUrl = images?['large_image_url'] ?? images?['image_url'];

    // Extraction genres avec filtrage
    final rawGenres = json['genres'] as List?;
    final genres = rawGenres
            ?.map((g) => g['name'] as String)
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];

    // Extraction chapitres (peut être null si en cours)
    final chapters = json['chapters'] as int?;

    // Synopsis avec nettoyage
    final rawSynopsis = json['synopsis'] as String?;
    final synopsis = rawSynopsis?.trim().isEmpty == true ? null : rawSynopsis;
    return Manga(
      id: firestoreId,
      malId: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: imageUrl,
      genres: genres,
      synopsis: synopsis,
      totalChapters: chapters,
      currentChapter: null, // À définir par l'utilisateur
      status: initialStatus ?? MangaStatus.toRead,
      rating: null, // À définir par l'utilisateur
      scanSite: scanSite,
      scanBaseUrl: scanBaseUrl,
      addedAt: DateTime.now(),
      updatedAt: null,
    );
  }

  // DEPUIS FIRESTORE
  factory Manga.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return Manga(
      id: documentId,
      malId: data['malId'] as int,
      title: data['title'] as String,
      imageUrl: data['imageUrl'] as String?,
      genres: List<String>.from(data['genres'] ?? []),
      synopsis: data['synopsis'] as String?,
      author: data['author'] as String?,
      totalChapters: data['totalChapters'] as int?,
      currentChapter: data['currentChapter'] as int?,
      status: MangaStatus.values[data['status'] as int],
      rating: (data['rating'] as num?)?.toDouble(),
      scanSite: data['scanSite'] as String,
      scanBaseUrl: data['scanBaseUrl'] as String?,

      // Conversion Timestamp → DateTime (firestore)
      addedAt: (data['addedAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // COPYWITH

  Manga copyWith({
    String? id,
    int? malId,
    String? title,
    String? imageUrl,
    List<String>? genres,
    String? synopsis,
    String? author,
    int? totalChapters,
    int? currentChapter,
    MangaStatus? status,
    double? rating,
    String? scanSite,
    String? scanBaseUrl,
    DateTime? addedAt,
    DateTime? updatedAt,
  }) {
    return Manga(
      id: id ?? this.id,
      malId: malId ?? this.malId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      genres: genres ?? this.genres,
      synopsis: synopsis ?? this.synopsis,
      author: author ?? this.author,
      totalChapters: totalChapters ?? this.totalChapters,
      currentChapter: currentChapter ?? this.currentChapter,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      scanSite: scanSite ?? this.scanSite,
      scanBaseUrl: scanBaseUrl ?? this.scanBaseUrl,
      addedAt: addedAt ?? this.addedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
