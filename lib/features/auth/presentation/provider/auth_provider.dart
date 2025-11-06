import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _userEmail;
  String? get userEmail => _userEmail;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await repository.login(email, password);
      _userEmail = user.email;
      _isAuthenticated = true;
    } catch (e) {
      _error = 'Login failed: $e';
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _userEmail = null;
    _error = null;
    notifyListeners();
  }
}
