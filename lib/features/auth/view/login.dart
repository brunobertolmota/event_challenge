import 'package:event_challenge/features/auth/controller/login_controller.dart';
import 'package:event_challenge/features/auth/errors/auth_firebase_exceptions.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:event_challenge/shared/utils/widgets/buttons_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            SvgPicture.asset('assets/images/login_logo.svg'),
            const SizedBox(height: 25),
            Text(
              'LOGIN',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: TextFormField(
                onChanged: (value) => controller.setEmailValue(value),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) => TextFormField(
                  onChanged: (value) => controller.setPasswordValue(value),
                  obscureText: controller.hidePassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    suffixIcon: InkWell(
                      onTap: controller.tooglePasswordView,
                      child: Icon(controller.hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            PurpleButton(
              label: 'Entrar',
              onPressed: () async {
                final status = await controller.logIn(
                    controller.email, controller.password);
                if (status == AuthStatus.successful) {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.green,
                      msg: 'Logado com sucesso!');

                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/homePage', (_) => false);
                } else {
                  final error =
                      AuthExceptionHandler.generateErrorMessage(status);
                  Fluttertoast.showToast(
                      backgroundColor: Colors.red, msg: error);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
