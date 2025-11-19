import '../repositories/manga_repository.dart';
import '../entities/manga_entity.dart';

class AddManga {
  final MangaRepository repository;

  AddManga(this.repository);

  Future<void> call(Manga manga) async {
    return repository.addManga(manga);
  }
}
