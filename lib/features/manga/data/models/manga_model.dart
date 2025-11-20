import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/manga_entity.dart';

class MangaModel {
  final String? id;
  final int malId;
  final String title;
  final String? imageUrl;
  final List<String> genres;
  final String? synopsis;
  final String? author;
  final int? totalChapters;
  final int? currentChapter;
  final int statusIndex;
  final double? rating;
  final String? scanSite;
  final String? scanBaseUrl;
  final DateTime addedAt;
  final DateTime? updatedAt;

  MangaModel({
    this.id,
    required this.malId,
    required this.title,
    this.imageUrl,
    required this.genres,
    this.synopsis,
    this.author,
    this.totalChapters,
    this.currentChapter,
    required this.statusIndex,
    this.rating,
    this.scanSite,
    this.scanBaseUrl,
    required this.addedAt,
    this.updatedAt,
  });

  //FACTORY 1 : Depuis Jikan API (COMPLET)
  factory MangaModel.fromJikanApi({
    required Map<String, dynamic> json,
    String? firestoreId,
    String? scanSite,
    String? scanBaseUrl,
    MangaStatus initialStatus = MangaStatus.toRead,
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

    // Auteur
    final authors = json['authors'] as List?;
    final author =
        authors?.isNotEmpty == true ? authors!.first['name'] as String? : null;

    return MangaModel(
      id: firestoreId,
      malId: json['mal_id'] as int,
      title: json['title'] as String,
      imageUrl: imageUrl,
      genres: genres,
      synopsis: synopsis,
      author: author,
      totalChapters: chapters,
      currentChapter: null,
      statusIndex: initialStatus.index,
      rating: null,
      scanSite: scanSite,
      scanBaseUrl: scanBaseUrl,
      addedAt: DateTime.now(),
      updatedAt: null,
    );
  }

  // FACTORY 2 : Depuis Firestore
  factory MangaModel.fromFirestore(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return MangaModel(
      id: documentId,
      malId: data['malId'] as int,
      title: data['title'] as String,
      imageUrl: data['imageUrl'] as String?,
      genres: List<String>.from(data['genres'] ?? []),
      synopsis: data['synopsis'] as String?,
      author: data['author'] as String?,
      totalChapters: data['totalChapters'] as int?,
      currentChapter: data['currentChapter'] as int?,
      statusIndex: data['status'] as int,
      rating: (data['rating'] as num?)?.toDouble(),
      scanSite: data['scanSite'] as String?,
      scanBaseUrl: data['scanBaseUrl'] as String?,
      addedAt: (data['addedAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // FACTORY 3 : Depuis Entity (pour sauvegarder)
  factory MangaModel.fromEntity(Manga entity) {
    return MangaModel(
      id: entity.id,
      malId: entity.malId,
      title: entity.title,
      imageUrl: entity.imageUrl,
      genres: entity.genres,
      synopsis: entity.synopsis,
      author: entity.author,
      totalChapters: entity.totalChapters,
      currentChapter: entity.currentChapter,
      statusIndex: entity.status.index,
      rating: entity.rating,
      scanSite: entity.scanSite,
      scanBaseUrl: entity.scanBaseUrl,
      addedAt: entity.addedAt,
      updatedAt: entity.updatedAt,
    );
  }

  // CONVERSION vers Entity
  Manga toEntity() {
    return Manga(
      id: id,
      malId: malId,
      title: title,
      imageUrl: imageUrl,
      genres: genres,
      synopsis: synopsis,
      author: author,
      totalChapters: totalChapters,
      currentChapter: currentChapter,
      status: MangaStatus.values[statusIndex],
      rating: rating,
      scanSite: scanSite,
      scanBaseUrl: scanBaseUrl,
      addedAt: addedAt,
      updatedAt: updatedAt,
    );
  }

  // CONVERSION vers Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'malId': malId,
      'title': title,
      'imageUrl': imageUrl,
      'genres': genres,
      'synopsis': synopsis,
      'author': author,
      'totalChapters': totalChapters,
      'currentChapter': currentChapter,
      'status': statusIndex,
      'rating': rating,
      'scanSite': scanSite,
      'scanBaseUrl': scanBaseUrl,
      'addedAt': Timestamp.fromDate(addedAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
