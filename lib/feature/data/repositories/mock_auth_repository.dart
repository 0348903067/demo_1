import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';

class MockAuthRepository implements AuthRepository {
  static const String defaultEmail = '123456@example.com';
  static const String defaultPassword = '123456';

  @override
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    // simulate latency
    await Future.delayed(const Duration(milliseconds: 700));

    if (email.trim() == defaultEmail && password == defaultPassword) {
      return const Right(unit);
    } else {
      return const Left(ServerFailure('Invalid credentials'));
    }
  }
}
