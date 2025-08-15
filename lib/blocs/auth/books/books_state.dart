import 'package:equatable/equatable.dart';
import 'package:alhekma/models/book_model.dart';

class BooksState extends Equatable {
  final bool loading;
  final List<Book> books;
  final Book? selectedBook;
  final String? error;

  const BooksState({
    this.loading = false,
    this.books = const [],
    this.selectedBook,
    this.error,
  });

  BooksState copyWith({
    bool? loading,
    List<Book>? books,
    Book? selectedBook,
    String? error,
  }) {
    return BooksState(
      loading: loading ?? this.loading,
      books: books ?? this.books,
      selectedBook: selectedBook ?? this.selectedBook,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, books, selectedBook, error];
}
