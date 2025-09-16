import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../../../../core/error/failures.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
