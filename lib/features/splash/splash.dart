import 'dart:async';

import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_assets.dart';
import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = getIt<FirebaseAuth>();

  Future<void> checkAuthStatusAndNavigate(context) async {
    Future.delayed(const Duration(seconds: 2), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          if (!mounted) return;
          Navigator.popAndPushNamed(context, '/login');
        } else {
          if (!mounted) return;
          Navigator.popAndPushNamed(context, '/homePage');
        }
      });
    });
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    checkAuthStatusAndNavigate(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.purple,
      child: Center(
        child: SvgPicture.asset(AppImages.splash),
      ),
    );
  }
}
