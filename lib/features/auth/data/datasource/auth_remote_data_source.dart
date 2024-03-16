import 'package:codeinit/core/error/exceptions.dart';
import 'package:codeinit/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name, required String email, required String password});
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserModel?> get getCurrentUserData;
  Future<String> signOut();
}

class AuthRemoteDataSourceImple implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  AuthRemoteDataSourceImple({required this.supabaseClient});
  @override
  Future<UserModel?> get getCurrentUserData async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email!);
      } else {
        return null;
      }
    } catch (e) {
      throw UserNotFound();
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      AuthResponse response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw SignInFailed();
      } else {
        return UserModel(
          id: response.user!.id,
          email: email,
          name: email,
        );
      }
    } catch (e) {
      throw SignInFailed();
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    AuthResponse response = await supabaseClient.auth.signUp(
      password: password,
      email: email,
      data: {"name": name},
    );
    if (response.user == null) {
      throw SignUpFailed();
    } else {
      return UserModel(id: response.user!.id, name: name, email: email);
    }
  }

  @override
  Future<String> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      return "Signed Out";
    } catch (e) {
      throw SignOutFailed();
    }
  }
}
