import '../models/manga_model.dart';

abstract class MangaRemoteDataSource {
  Future<List<MangaModel>> searchMangaByTitle(String query);
  Future<MangaModel> fetchMangaDetails(int malId);
}

// TODO: Implement remote calls to Jikan or other APIs and map responses to MangaModel
