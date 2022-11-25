import 'package:event_challenge/features/auth/view/login.dart';
import 'package:event_challenge/features/events/views/event_detail.dart';
import 'package:event_challenge/features/events/views/events_list.dart';
import 'package:event_challenge/features/events/views/favorites_event_list.dart';
import 'package:event_challenge/features/events/views/home_page.dart';
import 'package:event_challenge/features/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> routes(context) {
    return {
      '/splash': (context) => const SplashScreen(),
      '/login': (context) => const LoginPage(),
      '/homePage': (context) => const HomePage(),
      '/eventsList': (context) => const EventListPage(),
      '/favoriteEvents': (context) => FavoriteEventsListPage(),
      '/eventDetail': (context) => EventDetail(),
    };
  }
}
