class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({required this.token, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final tokens = json['tokens'];
    return AuthResponse(
      token: tokens['accessToken'],
      refreshToken: tokens['refreshToken'],
    );
  }
}
