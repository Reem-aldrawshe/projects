// profile_state.dart
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final String username;
  final String email;

  ProfileLoaded({required this.username, required this.email});
}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
class ProfileLogout extends ProfileState {}
