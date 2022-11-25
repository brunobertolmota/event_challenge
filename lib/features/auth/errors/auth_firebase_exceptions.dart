import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  successful,
  invalidEmail,
  wrongPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.wrongPassword:
        errorMessage = "E-mail ou senha incorretos";
        break;
      case AuthStatus.invalidEmail:
        errorMessage = "E-mail ou senha incorretos";
        break;
      default:
        errorMessage = "Ocorreu um erro não identificado.";
    }
    return errorMessage;
  }
}
