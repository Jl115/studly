import 'package:studly/app/features/auth/data/repositories/authrepository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<bool> call() async {
    return await repository.logout();
  }
}
