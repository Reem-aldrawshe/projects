import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/repository/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileData = await repository.getProfile();
        emit(ProfileLoaded(
          username: profileData['username'] ?? '---',
          email: profileData['email'] ?? '---',
        ));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<LogoutProfile>((event, emit) async {
      // مسح التوكن عند Logout
      await repository.authService.getValidAccessToken(); // إذا بدك مسح التوكن استخدم prefs مباشرة
      emit(ProfileLogout());
    });
  }
}
