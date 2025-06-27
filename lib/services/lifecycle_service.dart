import 'package:ueh_mobile_app/utils/exports.dart';

class StudentLifecycleService {
  late final AppLifecycleListener _listener;
  bool _isStudentUsingApp = true;

  StudentLifecycleService() {
    _listener = AppLifecycleListener(
      onShow: _handleShow,
      onResume: _handleResume,
      onHide: _handleHide,
      onInactive: _handleInactive,
      onPause: _handlePause,
      onDetach: _handleDetach,
      onRestart: _handleRestart,
      onStateChange: _handleStateChange,
    );
  }

  void _handleShow() {
    _isStudentUsingApp = true;
  }

  void _handleResume() {
    _isStudentUsingApp = true;
  }

  void _handleHide() {
    _isStudentUsingApp = false;
  }

  void _handleInactive() {
    _isStudentUsingApp = false;
  }

  void _handlePause() {
    _isStudentUsingApp = false;
  }

  void _handleDetach() {
    _isStudentUsingApp = false;
  }

  void _handleRestart() {
    _isStudentUsingApp = true;
  }

  void _handleStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _isStudentUsingApp = false;
    } else {
      _isStudentUsingApp = true;
    }
  }

  bool isStudentUsingApp() => _isStudentUsingApp;

  void dispose() {
    _listener.dispose();
  }
}

bool isStudentTraCuu(StudentLifecycleService lifecycleService) {
  return !lifecycleService.isStudentUsingApp();
}
