// auth_repository.dart
import 'package:test_app/models/auth_response_model.dart';
import 'package:test_app/models/user_register_model.dart';
import 'package:test_app/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> register(UserRegisterModel user) async {
    return _authService.register(user);
  }

  Future<AuthResponseModel> login(String username, String password) async {
    return _authService.login(username, password);
  }

  Future<void> refreshToken() async {
    return _authService.refreshToken();
  }

  Future<String?> getValidAccessToken() async {
    return _authService.getValidAccessToken();
  }
}
