part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(StatusState.idle) StatusState status,
    @Default(false) bool isAuthenticated,
    String? errorMessage,
  }) = _AuthState;
}
