// lib/features/manga/presentation/providers/discover_provider.dart

import 'package:flutter/foundation.dart';
import 'package:tomoyomu/features/manga/domain/entities/manga_entity.dart';

import '../../domain/repositories/jikan_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  final JikanMangaRepository _repository;

  DiscoverProvider({required JikanMangaRepository repository})
      : _repository = repository;

  // État
  bool _isLoading = false;
  String? _errorMessage;

  // Getters (lecture seule)
  
  List<Manga> _topMangas = [];
  List<Manga> get topMangas => _topMangas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get hasData => _topMangas.isNotEmpty;

  // Méthode pour charger les top mangas
  Future<void> loadTopMangas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Appel repository
      _topMangas = await _repository.getTopMangas();
    } catch (e) {
      _errorMessage = e.toString();
      _topMangas = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
