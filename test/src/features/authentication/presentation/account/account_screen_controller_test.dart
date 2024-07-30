import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/presentation/account/account_screen_controller.dart';

void main() {
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data(null)', () {
      final authRepository = FakeAuthRepository(addDelay: false);
      final controller = AccountScreenController(
        authRepository: authRepository,
      );
      expect(controller.state, const AsyncData<void>(null));
    });
  });
}
