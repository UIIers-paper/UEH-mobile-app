class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final tokens = json['tokens'];
    return AuthResponse(
<<<<<<< HEAD
      token: json['tokens']['accessToken'],
      refreshToken: json['tokens']['refreshToken'],
=======
      token: tokens['accessToken'],
      refreshToken: tokens['refreshToken'],
>>>>>>> 3eda070e9c79cb217865f7fbe24c1f74f8d0e710
    );
  }
}
