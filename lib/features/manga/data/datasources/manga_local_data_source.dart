import '../../domain/entities/manga_entity.dart';
import '../models/manga_model.dart';

abstract class MangaLocalDataSource {
  Future<void> insertManga(MangaModel model);
  Future<void> deleteManga(String id);
  Future<MangaModel?> getMangaById(String id);
  Future<List<MangaModel>> getAllMangas();
  Future<void> updateCurrentChapter(String id, int? chapter);
  Future<void> updateRating(String id, double rating);
  Future<void> updateStatus(String id, MangaStatus status);
  Future<void> updateScanSite(String id, String scanSite);
}

// TODO: Provide an implementation using chosen storage (SharedPreferences, SQLite, Firestore, etc.)
