import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hdi_test/pages/auth/repository/auth_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthEvent>(_onEvent);
    add(const AuthEvent.appStarted());
  }

  Future<void> _onEvent(AuthEvent event, Emitter<AuthState> emit) async {
    await event.when(
      appStarted: () => _onAppStarted(emit),
      loginSubmitted: (identifier, password) => _onLoginSubmitted(identifier, password, emit),
      logoutRequested: () => _onLogoutRequested(emit),
    );
  }

  Future<void> _onAppStarted(Emitter<AuthState> emit) async {
    final loggedIn = _authRepository.isLoggedIn();
    emit(state.copyWith(status: StatusState.loaded, isAuthenticated: loggedIn));
  }

  Future<void> _onLoginSubmitted(String identifier, String password, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: StatusState.loading, errorMessage: null));
    final result = await _authRepository.login(identifier, password);
    result.fold(
      (_) => emit(state.copyWith(status: StatusState.loaded, isAuthenticated: true)),
      (failure) => emit(
        state.copyWith(status: StatusState.error, errorMessage: failure.toString().replaceFirst('Exception: ', '')),
      ),
    );
  }

  Future<void> _onLogoutRequested(Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(state.copyWith(status: StatusState.loaded, isAuthenticated: false));
  }
}
