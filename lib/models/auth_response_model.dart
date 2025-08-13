// auth_response_model.dart
class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }
}
