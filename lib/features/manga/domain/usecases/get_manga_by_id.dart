import '../repositories/manga_repository.dart';
import '../entities/manga_entity.dart';

class GetMangaById {
  final MangaRepository repository;

  GetMangaById(this.repository);

  Future<Manga?> call(String id) async {
    return repository.getMangaById(id);
  }
}
