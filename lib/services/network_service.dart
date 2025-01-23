import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
class NetworkService {
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  late StreamSubscription<List<ConnectivityResult>> _subscription;





  Stream<bool> get connectionStream => _connectionController.stream;

  // void _startMonitoring() {
  //   final connectionChecker = InternetConnectionChecker.instance;
  //
  //   final subscription = connectionChecker.onStatusChange.listen(
  //         (InternetConnectionStatus status) {
  //       if (status == InternetConnectionStatus.connected) {
  //         print('Connected to the internet');
  //       } else {
  //         print('Disconnected from the internet');
  //       }
  //     },
  //   );
  //
  //   _checkInitialConnection();
  // }

  void startMonitoring(void Function(bool) onConnectionChange) {
    final connectionChecker = InternetConnectionChecker.instance;

    final _subscription = connectionChecker.onStatusChange.listen(
          (InternetConnectionStatus status) {
        bool isConnected = status == InternetConnectionStatus.connected;
        onConnectionChange(isConnected);
      },
    );
  }

  Future<void> _checkInitialConnection() async {
    bool initialConnection = await InternetConnectionChecker.instance.hasConnection;
    _connectionController.add(initialConnection);
  }

  void dispose() {
    _subscription.cancel();
    _connectionController.close();
  }

  Stream<ConnectivityResult> monitorNetwork() {
    return Connectivity().onConnectivityChanged.asyncExpand((connectivityList) {
      if (connectivityList.isNotEmpty) {
        return Stream.value(connectivityList.last);
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
    print("check");
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    print(status);
    return status == AirplaneModeStatus.on;
  }
}
