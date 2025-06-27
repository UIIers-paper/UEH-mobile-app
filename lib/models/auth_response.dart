class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken}); //, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['tokens']['accessToken'],
      refreshToken: json['tokens']['refreshToken'],
    );
  }
}