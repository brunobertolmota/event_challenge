import 'package:event_challenge/shared/routes/app_routes.dart';
import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.eventAppPurple,
      ),
      title: 'Events App',
      routes: Routes.routes(context),
      initialRoute: '/splash',
    );
  }
}
