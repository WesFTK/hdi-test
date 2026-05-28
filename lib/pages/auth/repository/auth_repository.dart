import 'package:hdi_test/utils/local_storage/local_storage.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepository {
  static const _validMemberId = 'MB001';
  static const _validPassword = 'password123';

  AsyncResult<bool> login(String identifier, String password) async {
    final isMemberId = identifier.toUpperCase() == _validMemberId;
    final isEmail = RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(identifier);

    if (!(isMemberId || isEmail)) {
      return Failure(Exception('Invalid member ID or email format.'));
    }
    if (password != _validPassword) {
      return Failure(Exception('Incorrect password.'));
    }

    await LocalStorage.setLoggedIn(true);
    return const Success(true);
  }

  AsyncResult<Unit> logout() async {
    await LocalStorage.setLoggedIn(false);
    return const Success(unit);
  }

  bool isLoggedIn() => LocalStorage.isLoggedIn;
}
