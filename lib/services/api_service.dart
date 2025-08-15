import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService([Dio? dio]) : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://alhekmah-server-side.onrender.com'));

  Future<List<dynamic>> fetchAllBooksRaw() async {
    final resp = await _dio.get('/books/');
    if (resp.statusCode == 200) {
      return resp.data as List<dynamic>;
    } else {
      throw Exception('Failed to fetch books: ${resp.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchBookByIdRaw(int id) async {
    final resp = await _dio.get('/books/$id');
    if (resp.statusCode == 200) {
      return Map<String, dynamic>.from(resp.data as Map);
    } else {
      throw Exception('Failed to fetch book $id: ${resp.statusCode}');
    }
  }
}
