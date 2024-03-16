import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, String>> signOut();
}
