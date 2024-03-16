import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthSignOutUseCase implements UseCase {
  final AuthRepository repository;

  AuthSignOutUseCase({required this.repository});
  @override
  Future<Either<Failure, dynamic>> call(params) async {
    try {
      return repository.signOut();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
