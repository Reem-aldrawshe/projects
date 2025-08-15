import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhekma/repository/books_repository.dart';
import 'books_event.dart';
import 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository repository;

  BooksBloc({required this.repository}) : super(const BooksState()) {
    on<BooksRequested>(_onBooksRequested);
    on<BookByIdRequested>(_onBookByIdRequested);
  }

  Future<void> _onBooksRequested(BooksRequested event, Emitter<BooksState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final books = await repository.fetchAndCacheAll();
      emit(state.copyWith(loading: false, books: books));
    } catch (e) {
      final cached = repository.getCachedBooks();
      if (cached.isNotEmpty) {
        emit(state.copyWith(loading: false, books: cached, error: e.toString()));
      } else {
        emit(state.copyWith(loading: false, books: [], error: e.toString()));
      }
    }
  }

  Future<void> _onBookByIdRequested(BookByIdRequested event, Emitter<BooksState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final book = await repository.fetchAndCacheById(event.id);
      emit(state.copyWith(loading: false, selectedBook: book));
    } catch (e) {
      final cached = repository.getCachedBookById(event.id);
      if (cached != null) {
        emit(state.copyWith(loading: false, selectedBook: cached, error: e.toString()));
      } else {
        emit(state.copyWith(loading: false, selectedBook: null, error: e.toString()));
      }
    }
  }
}
