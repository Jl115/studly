import 'package:studly/app/features/auth/data/repositories/authrepository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> call(String username, String password) async {
    return await repository.register(username, password);
  }
}
