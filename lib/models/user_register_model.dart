// user_register_model.dart
class UserRegisterModel {
  final String username;
  final String email;
  final String password;

  UserRegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
      };
}
