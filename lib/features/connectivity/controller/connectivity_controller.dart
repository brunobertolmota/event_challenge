import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityController extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  Future<void> initConnectivity() async {
    final result = await connectivity.checkConnectivity();
    updateConnectionStatus(result);
    connectivity.onConnectivityChanged.listen((event) {
      updateConnectionStatus(event);
    });
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    notifyListeners();
  }
}
