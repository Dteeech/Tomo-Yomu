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
  final DateTime addedAt;
  final DateTime? updatedAt;

  Manga({
    this.id,
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
