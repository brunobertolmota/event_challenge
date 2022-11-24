import 'package:event_challenge/features/auth/controller/login_controller.dart';
import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/events/views/events_list.dart';
import 'package:event_challenge/features/events/views/favorites_event_list.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventsController eventController = getIt<EventsController>();

  final LoginController loginController = getIt<LoginController>();

  final auth = getIt<FirebaseAuth>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Eventos'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () async {
                      await auth.signOut();
                      if (!mounted) {
                        return;
                      }
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Sair'),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            const TabBar(
              // indicatorSize: TabBarIndicatorSize.tab,
              // indicatorPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: EdgeInsets.only(top: 12.0, bottom: 2),
              indicatorColor: AppColors.purple,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              tabs: [
                Tab(text: 'Eventos Soft'),
                Tab(text: 'Meus eventos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  EventListPage(),
                  FavoriteEventsListPage(),
                ],
              ),
            ),
          ],
          // ),
        ),
      ),
    );
  }
}
