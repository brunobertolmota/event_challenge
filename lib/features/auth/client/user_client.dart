import 'package:event_challenge/features/auth/errors/auth_firebase_exceptions.dart';

abstract class UserLoginClient {
  Future<AuthStatus> logIn ({required String email, required String password});
  Future<AuthStatus> logOut();
}