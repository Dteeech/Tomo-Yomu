// empty
import 'package:flutter/material.dart';
import '../../domain/entities/manga_entity.dart';
import '../../domain/repositories/manga_repository.dart';

/// Provider minimal pour la feature manga.
/// TODO: Remplacer appels directs par UseCases et ajouter gestion d'erreurs.
class MangaProvider extends ChangeNotifier {
	final MangaRepository repository;

	List<Manga> _mangas = [];
	bool _loading = false;

	MangaProvider(this.repository);

	List<Manga> get mangas => _mangas;
	bool get loading => _loading;

	Future<void> loadMangas() async {
		_loading = true;
		notifyListeners();
		try {
			_mangas = await repository.getAllUserMangas();
		} finally {
			_loading = false;
			notifyListeners();
		}
	}

	Future<void> addManga(Manga m) async {
		await repository.addManga(m);
		await loadMangas();
	}
}

