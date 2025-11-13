import 'package:http/http.dart' as http;
import '../../domain/entities/manga_entity.dart';
import '../../domain/repositories/manga_repository.dart';

class JikanManagRepository implements MangaRepository {
  final http.Client httpClient;

  JikanManagRepository({required this.httpClient});

  @override
  Future<List<Manga>> getAllUserMangas() async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<Manga> getMangaById(String id) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<void> addManga(Manga manga) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<void> updateCurrentChapter(String mangaId, String chapter) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatus(String mangaId, MangaStatus status) async {
    // TODO: 
    throw UnimplementedError();
  }
  @override 
  Future<void> updateScanSite(String id, String scanSite) async {
    // TODO: 
    throw UnimplementedError();
  }
  @override
  Future<void> updateRating(String mangaId, double rating) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<void> deleteManga(String mangaId) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<List<Manga>> searchMangaFromApiByTitle(String query) async {
    // TODO: 
    throw UnimplementedError();
  }

  @override
  Future<Manga> getMangaDetails(int jikanId) async {
    // TODO: 
    throw UnimplementedError();
  }
}
