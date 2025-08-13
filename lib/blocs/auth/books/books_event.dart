import 'package:equatable/equatable.dart';

abstract class BooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BooksRequested extends BooksEvent {}

class BookByIdRequested extends BooksEvent {
  final int id;
  BookByIdRequested(this.id);

  @override
  List<Object?> get props => [id];
}
