import 'package:studly/app/features/auth/domain/entities/user.dart';
import 'package:studly/app/features/auth/domain/repositories/auth.repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User?> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
