import 'package:codeinit/core/common/cubit/app_user_cubit.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/core/entities/user.dart';
import 'package:codeinit/features/auth/data/models/user_model.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_sign_out.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthSignUpUseCase _userSignUpUseCase;
  final AuthSignInUseCase _userSignInUseCase;
  final AuthCurrentUserUseCase _currentUserUseCase;
  final AuthSignOutUseCase _signOutUseCase;

  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required AuthSignOutUseCase signOutUseCase,
      required AuthSignInUseCase userSignInUseCase,
      required AuthSignUpUseCase userSignUpUseCase,
      required AuthCurrentUserUseCase currentUserUseCase,
      required AppUserCubit appUserCubit})
      : _userSignUpUseCase = userSignUpUseCase,
        _appUserCubit = appUserCubit,
        _userSignInUseCase = userSignInUseCase,
        _currentUserUseCase = currentUserUseCase,
        _signOutUseCase = signOutUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthSignInEvent>(_onAuthSignInEvent);
    on<AuthCurrentUserEvent>(_currentUserEvent);
    on<AuthSignOutEvent> (_onAuthSignOutEvent);
  }
  void _onAuthSignOutEvent(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    final res = await _signOutUseCase(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSignOutSuccess()));
  }

  void _currentUserEvent(
      AuthCurrentUserEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUserUseCase(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  //functions
  void _onAuthSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUpUseCase.repository.signUpWithEmailAndPassword(
        user: event.user, email: event.email, password: event.password);
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _onAuthSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignInUseCase.repository.signInWithEmailAndPassword(
        email: event.email, password: event.password);
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

//everytime AuthSuccess is emitted, the user is updated
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
