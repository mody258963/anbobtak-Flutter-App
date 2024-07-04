class Auth {
  final String? accessToken;
  final String? tokenType;
  final int? userId;

  Auth({required this.accessToken,required this.tokenType,required this.userId});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      userId: json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user_id': userId,
    };
  }
}
