import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/core/entities/user.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthSignUpUseCase implements UseCase<User, UserSignUpParams> {
  final AuthRepository repository;

  AuthSignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    Either<Failure, User> res = await repository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
    return res;
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
