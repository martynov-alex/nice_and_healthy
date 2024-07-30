import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/presentation/account/account_screen_controller.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data(null)', () {
      final authRepository = MockAuthRepository();
      final controller = AccountScreenController(
        authRepository: authRepository,
      );
      verifyNever(authRepository.signOut);
      expect(controller.state, const AsyncData<void>(null));
    });

    test('signOut success', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(authRepository.signOut).thenAnswer((_) => Future.value());
      final controller = AccountScreenController(
        authRepository: authRepository,
      );
      // run
      await controller.signOut();
      // verify
      verify(() => authRepository.signOut()).called(1);
      expect(controller.state, const AsyncData<void>(null));
    });

    test('signOut failure', () async {
      // setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Connection failed');
      when(authRepository.signOut).thenThrow(exception);
      final controller = AccountScreenController(
        authRepository: authRepository,
      );
      // run
      await controller.signOut();
      // verify
      verify(() => authRepository.signOut()).called(1);
      expect(controller.state.hasError, true);
      // or
      expect(controller.state, isA<AsyncError<void>>());
      // or
      expect(controller.state.error, exception);
    });
  });
}
