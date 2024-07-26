part of 'google_auth_bloc.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthPending extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {
  final MyUser user;

  GoogleAuthSuccess(this.user);
}

class GoogleAuthError extends GoogleAuthState {
  final String message;

  GoogleAuthError(this.message);
}
