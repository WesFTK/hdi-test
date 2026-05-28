import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdi_test/pages/auth/bloc/auth_bloc.dart';
import 'package:hdi_test/pages/auth/repository/auth_repository.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
  });

  group('AuthBloc — init (AppStarted self-dispatched)', () {
    blocTest<AuthBloc, AuthState>(
      'emits authenticated when session exists',
      build: () {
        when(() => mockRepo.isLoggedIn()).thenReturn(true);
        return AuthBloc(authRepository: mockRepo);
      },
      expect: () => [
        const AuthState(status: StatusState.loaded, isAuthenticated: true),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits unauthenticated when no session',
      build: () {
        when(() => mockRepo.isLoggedIn()).thenReturn(false);
        return AuthBloc(authRepository: mockRepo);
      },
      expect: () => [
        const AuthState(status: StatusState.loaded, isAuthenticated: false),
      ],
    );
  });

  group('AuthBloc — LoginSubmitted', () {
    blocTest<AuthBloc, AuthState>(
      'emits loading then authenticated on valid credentials',
      build: () {
        when(() => mockRepo.login('MB001', 'password123'))
            .thenAnswer((_) async => const Success(true));
        return AuthBloc(authRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        const AuthEvent.loginSubmitted(
            identifier: 'MB001', password: 'password123'),
      ),
      expect: () => [
        const AuthState(status: StatusState.loading),
        const AuthState(status: StatusState.loaded, isAuthenticated: true),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits loading then error on invalid credentials',
      build: () {
        when(() => mockRepo.login('MB001', 'wrong'))
            .thenAnswer((_) async => Failure(Exception('Incorrect password.')));
        return AuthBloc(authRepository: mockRepo);
      },
      act: (bloc) => bloc.add(
        const AuthEvent.loginSubmitted(
            identifier: 'MB001', password: 'wrong'),
      ),
      expect: () => [
        const AuthState(status: StatusState.loading),
        const AuthState(
            status: StatusState.error,
            errorMessage: 'Incorrect password.'),
      ],
    );
  });

  group('AuthBloc — LogoutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits unauthenticated after logout',
      build: () {
        when(() => mockRepo.logout())
            .thenAnswer((_) async => const Success(unit));
        return AuthBloc(authRepository: mockRepo);
      },
      act: (bloc) => bloc.add(const AuthEvent.logoutRequested()),
      expect: () => [
        const AuthState(status: StatusState.loaded, isAuthenticated: false),
      ],
    );
  });
}
