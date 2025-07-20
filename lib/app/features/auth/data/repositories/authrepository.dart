import '../../domain/entities/user.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepository(this.localDataSource);

  Future<User?> login(String username, String password) async {
    return await localDataSource.login(username, password);
  }

  Future<bool> register(String username, String password) async {
    return await localDataSource.register(username, password);
  }

  Future<bool> logout() async {
    return await localDataSource.logout();
  }

  Future<User?> getCurrentUser() async {
    return await localDataSource.getCurrentUser();
  }

  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }
}
