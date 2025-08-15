import 'package:equatable/equatable.dart';
import 'package:alhekma/models/auth_response_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthResponseModel authResponse;

  AuthAuthenticated(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}
