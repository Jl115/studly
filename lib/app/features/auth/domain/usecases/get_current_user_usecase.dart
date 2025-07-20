import 'package:studly/app/features/auth/data/repositories/authrepository.dart';

import '../entities/user.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
