import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/manga.dart';
import '../../domain/repositories/manga_repository.dart';

class JikanManagRepository implements MangaRepository {
  final http.Client httpClient;

  JikanManagRepository({required this.httpClient});

  @override
  Future<List<Manga>> getAllUserMangas() async {
    // TODO: Implémenter l'appel API Jikan
    throw UnimplementedError();
  }

  @override
  Future<Manga> getMangaById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<void> addManga(Manga manga) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateCurrentChapter(String mangaId, String chapter) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatus(String mangaId, MangaStatus status) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateRating(String mangaId, double rating) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteManga(String mangaId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Manga>> searchMangaByTitle(String query) async {
    throw UnimplementedError();
  }

  @override
  Future<Manga> getMangaDetails(String jikanId) async {
    throw UnimplementedError();
  }
}
