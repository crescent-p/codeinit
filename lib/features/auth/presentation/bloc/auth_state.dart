part of 'auth_bloc.dart';

@immutable
sealed class AuthStateMine {}

final class AuthInitial extends AuthStateMine {}

final class AuthLoading extends AuthStateMine {}

final class AuthSuccess extends AuthStateMine {
  final User user;

  AuthSuccess({required this.user});
}

final class AuthFailure extends AuthStateMine {
  final String message;

  AuthFailure({required this.message});
}

final class AuthSignOutSuccess extends AuthStateMine {
  AuthSignOutSuccess();
}
