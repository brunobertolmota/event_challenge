import 'package:event_challenge/features/auth/client/user_client.dart';
import 'package:event_challenge/features/auth/errors/auth_firebase_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseServiceImpl implements UserLoginClient {
  final FirebaseAuth auth;

  AuthFirebaseServiceImpl({
    required this.auth,
  });

  AuthStatus status = AuthStatus.unknown;

  @override
  Future<AuthStatus> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }

  @override
  Future<AuthStatus> logOut() async {
    try {
      await auth.signOut();
      status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }
}
