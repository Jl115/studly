import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String username, String password);
  Future<bool> register(String username, String password);
  Future<bool> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
}
