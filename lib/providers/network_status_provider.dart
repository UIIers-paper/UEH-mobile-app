import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatusProvider with ChangeNotifier {
  bool _isInternetConnected = true;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool get isInternetConnected => _isInternetConnected;

  NetworkStatusProvider() {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _isInternetConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  void updateNetworkStatus(bool isConnected) {
    if (_isInternetConnected != isConnected) {
      _isInternetConnected = isConnected;
      notifyListeners();  // Thông báo để UI cập nhật
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
