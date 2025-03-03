class UserLog {
  String logId;
  String userId;
  String deviceId;
  Map<String, dynamic> deviceInfo;
  String loginTime;
  String logoutTime;

  UserLog({
    required this.logId,
    required this.userId,
    required this.deviceId,
    required this.deviceInfo,
    required this.loginTime,
    required this.logoutTime,
  });

  factory UserLog.fromJson(Map<String, dynamic> json) {
    return UserLog(
      logId: json['log_id'],
      userId: json['user_id'],
      deviceId: json['device_id'],
      deviceInfo: json['device_info'],
      loginTime: json['login_time'],
      logoutTime: json['logout_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'log_id': logId,
      'user_id': userId,
      'device_id': deviceId,
      'device_info': deviceInfo,
      'login_time': loginTime,
      'logout_time': logoutTime,
    };
  }
}