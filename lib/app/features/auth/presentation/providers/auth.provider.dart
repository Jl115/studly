import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/auth_usecases.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  });

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  Future<void> login(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await loginUseCase(username, password);
      if (user != null) {
        _currentUser = user;
        notifyListeners();
      } else {
        _setError('Invalid username or password');
      }
    } catch (e) {
      _setError('Login failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await registerUseCase(username, password);
      if (!success) {
        _setError('Registration failed. User might already exist.');
      }
    } catch (e) {
      _setError('Registration failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    _clearError();

    try {
      await logoutUseCase();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      _setError('Logout failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkAuthStatus() async {
    _setLoading(true);
    try {
      final user = await getCurrentUserUseCase();
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      _setError('Failed to check auth status: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> handleSubmit(formKey, isLogin, usernameController, passwordController) async {
    if (formKey.currentState!.validate()) {
      if (isLogin) {
        await login(usernameController.text, passwordController.text);
        return;
      }
      await register(usernameController.text, passwordController.text);
      if (errorMessage != null) {
        // If registration failed, do not proceed to login
        return;
      }
      // Registration successful, now login
      await login(usernameController.text, passwordController.text);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
