import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/services/network_service.dart';

class AirplaneModeProvider with ChangeNotifier {
  final NetworkService networkService = NetworkService();
  bool _isAirplaneModeEnabled = false;

  bool get isAirplaneModeEnabled => _isAirplaneModeEnabled;

  void checkAirplaneMode() async {
    _isAirplaneModeEnabled = await networkService.isAirplaneModeEnabled();
    notifyListeners();
  }
}
