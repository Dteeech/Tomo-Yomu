import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/manga_entity.dart';
import '../../domain/repositories/manga_repository.dart';
import '../datasources/manga_local_data_source.dart';
import '../datasources/manga_remote_data_source.dart';
import '../models/manga_model.dart';

class MangaRepositoryImpl implements MangaRepository {
  final MangaLocalDataSource localDataSource;
  final MangaRemoteDataSource remoteDataSource;

  MangaRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<void> addManga(Manga manga) async {
    // Map to model and persist locally (or forward to remote)
    final model = MangaModel.fromEntity(manga);
    return localDataSource.insertManga(model);
  }

  @override
  Future<void> deleteManga(String id) async {
    return localDataSource.deleteManga(id);
  }

  @override
  Future<Manga?> getMangaById(String id) async {
    final model = await localDataSource.getMangaById(id);
    return model?.toEntity();
  }

  @override
  Future<List<Manga>> getAllUserMangas() async {
    final models = await localDataSource.getAllMangas();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Manga> getMangaDetails(int malId) async {
    final model = await remoteDataSource.fetchMangaDetails(malId);
    return model.toEntity();
  }

  @override
  Future<List<Manga>> searchMangaFromApiByTitle(String query) async {
    final models = await remoteDataSource.searchMangaByTitle(query);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateCurrentChapter(String id, String chapter) async {
    return localDataSource.updateCurrentChapter(id, int.tryParse(chapter));
  }

  @override
  Future<void> updateRating(String id, double rating) async {
    return localDataSource.updateRating(id, rating);
  }

  @override
  Future<void> updateScanSite(String id, String scanSite) async {
    return localDataSource.updateScanSite(id, scanSite);
  }

  @override
  Future<void> updateStatus(String id, MangaStatus status) async {
    return localDataSource.updateStatus(id, status);
  }
}
