// auth_event.dart
import 'package:equatable/equatable.dart';
import 'package:test_app/models/user_register_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterRequested extends AuthEvent {
  final UserRegisterModel user;

  RegisterRequested(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class LogoutRequested extends AuthEvent {}
