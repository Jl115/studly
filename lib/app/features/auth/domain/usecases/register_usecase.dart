import 'package:studly/app/features/auth/domain/repositories/auth.repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> call(String username, String password) async {
    return await repository.register(username, password);
  }
}
