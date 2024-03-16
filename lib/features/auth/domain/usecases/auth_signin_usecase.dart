import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user.dart';

class AuthSignInUseCase implements UseCase<User, UserSignInParams> {
  final AuthRepository repository;

  AuthSignInUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    //use await because in some cases the future might not be resolved
    return await repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams(
      { required this.email, required this.password});
}
