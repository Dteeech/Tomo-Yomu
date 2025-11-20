import 'package:tomoyomu/features/manga/domain/entities/manga_entity.dart';

abstract class JikanMangaRepository {
 Future<List<Manga>> getTopMangas({
    int page =1,
    int limit = 25
  });
}