// 📁 lib/features/manga/data/repositories/jikan_manga_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/manga_entity.dart';
import '../../domain/repositories/jikan_repository.dart';
import '../models/manga_model.dart';

class JikanMangaRepositoryImpl implements JikanMangaRepository {
  final http.Client httpClient;

  JikanMangaRepositoryImpl({required this.httpClient});

  
  @override
  Future<List<Manga>> getTopMangas({int page = 1, int limit = 25}) async {
    try {
      final url = Uri.parse(
        'https://api.jikan.moe/v4/top/manga?page=$page&limit=$limit',
      );

      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> mangasJson = jsonData['data'];

        // 🔧 Vérifie le nom exact de la factory dans manga_model.dart
        return mangasJson
            .map<Manga>((json) => MangaModel.fromJikanApi(json: json).toEntity())
            .toList();
      }

      throw Exception('Failed to load top mangas: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching top mangas: $e');
    }
  }

  @override
  Future<Manga> getMangaDetails(int jikanId) async {
    try {
      final url = Uri.parse('https://api.jikan.moe/v4/manga/$jikanId');
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final Map<String, dynamic> mangaData = jsonData['data'];

        return MangaModel.fromJikanApi(
          json: mangaData,
          firestoreId: null,
          scanSite: null,
          scanBaseUrl: null,
          initialStatus: MangaStatus.toRead,
        ).toEntity();
      }

      throw Exception('Failed to load manga details: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching manga details: $e');
    }
  }

  @override
  Future<List<Manga>> searchMangaByTitle(String query) async {
    try {
      final url = Uri.parse(
        'https://api.jikan.moe/v4/manga?q=$query&limit=20',
      );

      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> mangasJson = jsonData['data'];

        return mangasJson
            .map<Manga>((json) => MangaModel.fromJikanApi(json: json).toEntity())
            .toList();
      }

      throw Exception('Search failed: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error searching manga: $e');
    }
  }
}
