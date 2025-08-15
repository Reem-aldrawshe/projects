import 'package:hive/hive.dart';
import '../models/book_model.dart';
import '../services/api_service.dart';
import '../local/hive_helper.dart';

class BooksRepository {
  final ApiService _api;
  late final Box<Book> _box;

  BooksRepository({ApiService? api}) : _api = api ?? ApiService() {
    _box = Hive.box<Book>(HiveHelper.booksBoxName);
  }

  Future<List<Book>> fetchAndCacheAll() async {
    final raw = await _api.fetchAllBooksRaw();
    final List<Book> books = raw.map((e) => Book.fromJson(Map<String, dynamic>.from(e))).toList();

    await _box.clear();
    for (final book in books) {
      await _box.put(book.id, book);
    }
    return books;
  }

  Future<Book> fetchAndCacheById(int id) async {
    final raw = await _api.fetchBookByIdRaw(id);
    final book = Book.fromJson(raw);
    await _box.put(book.id, book);
    return book;
  }

  List<Book> getCachedBooks() {
    return _box.values.toList();
  }

  Book? getCachedBookById(int id) {
    return _box.get(id);
  }
}
