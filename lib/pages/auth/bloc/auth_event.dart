part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = AppStarted;
  const factory AuthEvent.loginSubmitted({
    required String identifier,
    required String password,
  }) = LoginSubmitted;
  const factory AuthEvent.logoutRequested() = LogoutRequested;
}
