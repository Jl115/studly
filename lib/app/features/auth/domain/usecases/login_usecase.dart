import 'package:studly/app/features/auth/data/repositories/authrepository.dart';
import 'package:studly/app/features/auth/domain/entities/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User?> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
