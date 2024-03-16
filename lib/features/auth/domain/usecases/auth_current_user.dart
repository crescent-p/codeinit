import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';

class AuthCurrentUserUseCase implements UseCase<User, NoParams> {
  final AuthRepository repository;

  AuthCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    try {
      return await repository.getCurrentUser();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
