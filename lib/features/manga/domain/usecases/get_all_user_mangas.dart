import '../repositories/manga_repository.dart';
import '../entities/manga_entity.dart';

class GetAllUserMangas {
  final MangaRepository repository;

  GetAllUserMangas(this.repository);

  Future<List<Manga>> call() async {
    return repository.getAllUserMangas();
  }
}
