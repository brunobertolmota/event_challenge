import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_challenge/features/auth/controller/login_controller.dart';
import 'package:event_challenge/features/connectivity/controller/connectivity_controller.dart';
import 'package:event_challenge/features/events/views/events_list.dart';
import 'package:event_challenge/features/events/views/favorites_event_list.dart';
import 'package:event_challenge/shared/core/dependencies.dart';
import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    connectivityController.initConnectivity();
  }

  final LoginController loginController = getIt<LoginController>();

  final ConnectivityController connectivityController =
      getIt<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: _appBardConnectionStatus(),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          title: const Text('Eventos'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      loginController.logOut().then((value) =>
                          Navigator.pushReplacementNamed(context, '/login'));
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
                  const EventListPage(),
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

  Widget _appBardConnectionStatus() {
    return AnimatedBuilder(
      animation: connectivityController,
      builder: (context, _) => connectivityController.connectionStatus ==
              ConnectivityResult.wifi
          ? const Icon(
              Icons.wifi,
              color: Colors.green,
            )
          : connectivityController.connectionStatus == ConnectivityResult.mobile
              ? const Icon(
                  Icons.signal_cellular_alt,
                  color: Colors.yellow,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
    );
  }
}
