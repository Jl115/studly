import 'package:studly/app/features/auth/domain/repositories/auth.repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<bool> call() async {
    return await repository.logout();
  }
}
