import '../../domain/entities/manga_entity.dart';

class MangaModel {
  final String id;
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
  final String scanSite;
  final String? scanBaseUrl;
  final DateTime addedAt;
  final DateTime? updatedAt;

  MangaModel({
    required this.id,
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
    required this.scanSite,
    this.scanBaseUrl,
    required this.addedAt,
    this.updatedAt,
  });

  factory MangaModel.fromEntity(Manga e) {
    return MangaModel(
      id: e.id,
      malId: e.malId,
      title: e.title,
      imageUrl: e.imageUrl,
      genres: e.genres,
      synopsis: e.synopsis,
      author: e.author,
      totalChapters: e.totalChapters,
      currentChapter: e.currentChapter,
      statusIndex: e.status.index,
      rating: e.rating,
      scanSite: e.scanSite,
      scanBaseUrl: e.scanBaseUrl,
      addedAt: e.addedAt,
      updatedAt: e.updatedAt,
    );
  }

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
}
