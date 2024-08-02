import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(GoogleAuthInitial()) {
    on<GoogleSignInEvent>(_signInWithGoogle);
  }

  final UserRepository _userRepository;

  Future<void> _signInWithGoogle(
      GoogleSignInEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthPending());
    try {
      final user = await _userRepository.signInWithGoogle();
      if (user == null) {
        emit(GoogleAuthError('Sign in failed'));
        return;
      }

      final userExists = await _userRepository.checkUserExists(user.userId);

      if (!userExists) {
        await _userRepository.setUserData(user);
      }

      emit(GoogleAuthSuccess(user));
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }
}
