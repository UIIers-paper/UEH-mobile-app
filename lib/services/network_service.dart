import 'package:ueh_mobile_app/utils/exports.dart';
import 'dart:async';
class NetworkService {
  Stream<ConnectivityResult> monitorNetwork() {
    return Connectivity().onConnectivityChanged.asyncExpand((connectivityList) {
      if (connectivityList.isNotEmpty) {
        return Stream.value(connectivityList.first);
      } else {
        return Stream.value(ConnectivityResult.none);
      }
    });
  }


  Future<bool> checkNetworkStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;

  }

  Future<bool> isAirplaneModeEnabled() async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    return status == AirplaneModeStatus.on;
  }
}
