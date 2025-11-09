import '../entities/manga.dart';

abstract class MangaRepository {
  Future<List<Manga>> getAllUserMangas();
  Future<Manga?> getMangaById(String id);

  Future<void> addManga(Manga manga);

  Future<void> updateCurrentChapter(String id, String chapter);
  Future<void> updateStatus(String id, MangaStatus status);
  Future<void> updateRating(String id, double rating);
  Future<void> updateScanSite(String id, String scanSite);

  Future<void> deleteManga(String id);

  Future<List<Manga>> searchMangaFromApi(String query);
  Future<Manga> getMangaDetail(int malId);
}