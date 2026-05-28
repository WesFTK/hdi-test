import 'package:flutter_test/flutter_test.dart';
import 'package:hdi_test/pages/auth/repository/auth_repository.dart';
import 'package:hdi_test/utils/local_storage/local_storage.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await LocalStorage.init();
  });

  setUp(() async {
    await LocalStorage.setLoggedIn(false);
  });

  group('AuthRepository.login', () {
    late AuthRepository repo;

    setUp(() => repo = AuthRepository());

    test('succeeds with valid member ID and correct password', () async {
      final result = await repo.login('MB001', 'password123');
      expect(result.isSuccess(), isTrue);
    });

    test('succeeds with lowercase member ID', () async {
      final result = await repo.login('mb001', 'password123');
      expect(result.isSuccess(), isTrue);
    });

    test('succeeds with valid email and correct password', () async {
      final result = await repo.login('user@example.com', 'password123');
      expect(result.isSuccess(), isTrue);
    });

    test('fails on wrong password', () async {
      final result = await repo.login('MB001', 'wrongpass');
      expect(result.isError(), isTrue);
    });

    test('fails on invalid identifier (not member ID or email)', () async {
      final result = await repo.login('notAnEmail', 'password123');
      expect(result.isError(), isTrue);
    });

    test('fails on empty password', () async {
      final result = await repo.login('MB001', '');
      expect(result.isError(), isTrue);
    });
  });

  group('AuthRepository session', () {
    late AuthRepository repo;

    setUp(() => repo = AuthRepository());

    test('isLoggedIn returns false before login', () {
      expect(repo.isLoggedIn(), isFalse);
    });

    test('isLoggedIn returns true after successful login', () async {
      await repo.login('MB001', 'password123');
      expect(repo.isLoggedIn(), isTrue);
    });

    test('isLoggedIn returns false after logout', () async {
      await repo.login('MB001', 'password123');
      await repo.logout();
      expect(repo.isLoggedIn(), isFalse);
    });
  });
}
