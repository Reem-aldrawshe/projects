import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/models/auth_response_model.dart';
import 'package:test_app/models/user_register_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://alhekmah-server-side.onrender.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  AuthService() {
    // هذا يسمح بتخطي التحقق من شهادة SSL (فقط للتجربة، لا تستخدم في الإنتاج)
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        };
  }

  Future<void> register(UserRegisterModel user) async {
    try {
      print('Sending registration data: ${user.toJson()}');
      final response = await _dio.post('/auth/register', data: user.toJson());
      print('Register response status: ${response.statusCode}');
      print('Register response data: ${response.data}');
    } on DioError catch (dioError) {
      print('DioError during registration: ${dioError.message}');
      if (dioError.response != null) {
        print('Response status: ${dioError.response?.statusCode}');
        print('Response data: ${dioError.response?.data}');
      }
      throw Exception(
        'Registration failed: ${dioError.response?.data ?? dioError.message}',
      );
    } catch (e) {
      print('Unknown error during registration: $e');
      throw Exception('Registration failed: $e');
    }
  }

  Future<AuthResponseModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', authResponse.accessToken);
      await prefs.setString('refresh_token', authResponse.refreshToken);

      // ممكن تضيف وقت انتهاء التوكن إذا متوفر من الباك
      return authResponse;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) throw Exception('No refresh token found');

    try {
      final response = await _dio.post(
        '/auth/refresh',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      await prefs.setString('access_token', newAccessToken);
      if (newRefreshToken != null) {
        await prefs.setString('refresh_token', newRefreshToken);
      }
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  Future<String?> getValidAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    // هنا لو بدك تضيف تحقق انتهاء صلاحية توكن ونعمل refresh
    // ممكن تضيف expiry logic لو متوفر

    return accessToken;
  }

  Future<Options> getAuthOptions() async {
    final token = await getValidAccessToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }
}
