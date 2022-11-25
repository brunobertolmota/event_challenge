import 'package:event_challenge/features/auth/client/user_client.dart';
import 'package:event_challenge/features/auth/errors/auth_firebase_exceptions.dart';
import 'package:flutter/cupertino.dart';


class LoginController extends ChangeNotifier {
  final UserLoginClient authService;

  LoginController({
    required this.authService,
  });

  bool hidePassword = true;

  String email = '';
  String password = '';

  setEmailValue(String value) => email = value;

  setPasswordValue(String value) => password = value;

  tooglePasswordView() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<AuthStatus> logIn(String email, String senha) async {
    final status =
        await authService.logIn(email: email, password: senha);
    return status;
  }

  Future<AuthStatus> logOut() async {
    final status = await authService.logOut();
    return status;
  }
}
