// import 'package:dio/io.dart';
// import 'package:alhekma/services/auth_service.dart';
// import 'package:dio/dio.dart';

// class ProfileRepository {
//   final AuthService authService;
//   final Dio _dio = Dio(
//     BaseOptions(baseUrl: 'https://alhekmah-server-side.onrender.com'),
//   );

//   ProfileRepository({required this.authService}) {
//     // تخطي SSL للـ dev (حسب authService)
//     (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//         (client) {
//       client.badCertificateCallback = (cert, host, port) => true;
//       return client;
//     };
//   }

//   Future<Map<String, dynamic>> getProfile() async {
//     final token = await authService.getValidAccessToken();
//     if (token == null) throw Exception('No access token found');

//     final response = await _dio.get(
//       '/profile', // endpoint البروفايل عندك
//       options: Options(headers: {'Authorization': 'Bearer $token'}),
//     );

//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       throw Exception('Failed to fetch profile');
//     }
//   }
// }
import 'package:dio/io.dart';
import 'package:alhekma/services/auth_service.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final AuthService authService;
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://alhekmah-server-side.onrender.com'),
  );

  ProfileRepository({required this.authService}) {
    
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
  }

  Future<Map<String, dynamic>> getProfile() async {
    final token = await authService.getValidAccessToken();
    if (token == null || token.isEmpty) throw Exception('No access token found');

    try {
      final response = await _dio.get(
        '/profile', 
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch profile');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }
}
