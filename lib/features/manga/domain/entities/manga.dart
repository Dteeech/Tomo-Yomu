// lib/features/manga/domain/entities/manga.dart

// import 'package:cloud_firestore/cloud_firestore.dart';

enum MangaStatus {
  inProgress,
  done,
  toRead,
  abandoned
}

class Manga {
  final String id;
  final int malId;
  final String title;
  final String? imageUrl;
  final List<String> genres;
  final String? synopsis;
  final int? totalChapters;
  final int? currentChapter;
  final MangaStatus status;
  final double? rating;
  final String scanSite;
  final String? scanBaseUrl;
  final DateTime addedAt;      // 👈 Type Dart
  final DateTime? updatedAt;   // 👈 Type Dart

  Manga({
    required this.id,
    required this.malId,
    required this.title,
    this.imageUrl,
    required this.genres,
    this.synopsis,
    this.totalChapters,
    this.currentChapter,
    required this.status,
    this.rating,
    required this.scanSite,
    this.scanBaseUrl,
    required this.addedAt,
    this.updatedAt,
  });

  // ═══════════════════════════════════════
  // DEPUIS API JIKAN
  // ═══════════════════════════════════════
  factory Manga.fromJikanApi({
    required Map<String, dynamic> json,
    required String firestoreId,
    required String scanSite,
    String? scanBaseUrl,
    MangaStatus? initialStatus,
  }) {
    // Extraction image URL (priorité large > default)
    final images = json['images']?['jpg'];
    final imageUrl = images?['large_image_url'] ?? 
                     images?['image_url'];

    // Extraction genres avec filtrage
    final rawGenres = json['genres'] as List?;
    final genres = rawGenres
        ?.map((g) => g['name'] as String)
        .where((name) => name.isNotEmpty)
        .toList() 
        ?? [];

    // Extraction chapitres (peut être null si en cours)
    final chapters = json['chapters'] as int?;

    // Synopsis avec nettoyage
    final rawSynopsis = json['synopsis'] as String?;
    final synopsis = rawSynopsis?.trim().isEmpty == true 
        ? null 
        : rawSynopsis;

    return Manga(
      id: firestoreId,
      malId: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: imageUrl,
      genres: genres,
      synopsis: synopsis,
      totalChapters: chapters,
      currentChapter: null,  // À définir par l'utilisateur
      status: initialStatus ?? MangaStatus.toRead,
      rating: null,  // À définir par l'utilisateur
      scanSite: scanSite,
      scanBaseUrl: scanBaseUrl,
      addedAt: DateTime.now(),  // 👈 DateTime natif
      updatedAt: null,
    );
  }

  // ═══════════════════════════════════════
  // DEPUIS FIRESTORE
  // ═══════════════════════════════════════
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
      totalChapters: data['totalChapters'] as int?,
      currentChapter: data['currentChapter'] as int?,
      status: MangaStatus.values[data['status'] as int],
      rating: (data['rating'] as num?)?.toDouble(),
      scanSite: data['scanSite'] as String,
      scanBaseUrl: data['scanBaseUrl'] as String?,
      
      // Conversion Timestamp → DateTime
      addedAt: (data['addedAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // ═══════════════════════════════════════
  // VERS FIRESTORE
  // ═══════════════════════════════════════
  Map<String, dynamic> toFirestore() {
    return {
      'malId': malId,
      'title': title,
      'imageUrl': imageUrl,
      'genres': genres,
      'synopsis': synopsis,
      'totalChapters': totalChapters,
      'currentChapter': currentChapter,
      'status': status.index,
      'rating': rating,
      'scanSite': scanSite,
      'scanBaseUrl': scanBaseUrl,
      
      // Conversion DateTime → Timestamp
      'addedAt': Timestamp.fromDate(addedAt),
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : null,
    };
  }

  // ═══════════════════════════════════════
  // MÉTHODES UTILITAIRES
  // ═══════════════════════════════════════
  String getChapterUrl() {
    if (scanBaseUrl == null || currentChapter == null) return '';
    final slug = title.toLowerCase().replaceAll(' ', '-');
    return '$scanBaseUrl/manga/$slug/chapitre-$currentChapter/';
  }

  double? getProgressPercentage() {
    if (totalChapters == null || 
        totalChapters == 0 || 
        currentChapter == null) {
      return null;
    }
    final pct = (currentChapter! / totalChapters!) * 100;
    return pct.clamp(0, 100);
  }

  String getStatusLabel() {
    switch (status) {
      case MangaStatus.inProgress:
        return ' En cours';
      case MangaStatus.done:
        return ' Terminé';
      case MangaStatus.toRead:
        return ' À lire';
      case MangaStatus.abandoned:
        return ' Abandonné';
    }
  }

  // ═══════════════════════════════════════
  // COPYWITH
  // ═══════════════════════════════════════
  Manga copyWith({
    String? id,
    int? malId,
    String? title,
    String? imageUrl,
    List<String>? genres,
    String? synopsis,
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
