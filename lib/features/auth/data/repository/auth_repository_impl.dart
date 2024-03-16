import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/network/connection_checker.dart';
import 'package:codeinit/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:codeinit/features/auth/data/models/user_model.dart';
import 'package:codeinit/core/entities/user.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final Network network;

  AuthRepositoryImpl({
    required this.network,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    final session = await authRemoteDataSource.getCurrentUserData;
    try {
      if (!await network.isConnected) {
        if (session != null) {
          return Right(UserModel(
            id: session.id,
            name: session.name,
            email: session.email,
            image_url: session.image_url,
            phone_number: session.phone_number,
            website: session.website,
            designation: session.designation,
          ));
        } else {
          return Left(
            Failure(message: 'No internet connection'),
          );
        }
      }

      if (session == null) {
        return left(Failure(message: 'No user logged in'));
      } else {
        return right(UserModel(
          id: session.id,
          name: session.name,
          email: session.email,
          image_url: session.image_url,
          phone_number: session.phone_number,
          website: session.website,
          designation: session.designation,
        ));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() => authRemoteDataSource.signInWithEmailAndPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required UserModel user,
      required String email,
      required String password}) async {
    return _getUser(() => authRemoteDataSource.signUpWithEmailAndPassword(
        user: user, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(
      Future<User> Function() function) async {
    try {
      if (!await network.isConnected) {
        return Left(Failure(message: 'No internet connection'));
      }
      final result = await function();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      final res = await authRemoteDataSource.signOut();
      if (res == 'Signed Out') {
        return const Right('SignOut');
      } else {
        return Left(Failure(message: 'SignOut Failed'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
