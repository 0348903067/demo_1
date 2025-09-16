import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';

abstract class AuthRepository {
  /// Login with email & password
  /// Returns Right(unit) on success or Left(Failure) on failure
  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  });
}
