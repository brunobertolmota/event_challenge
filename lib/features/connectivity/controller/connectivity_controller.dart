import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityController extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    result = await connectivity.checkConnectivity();

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    notifyListeners();
  }
}
