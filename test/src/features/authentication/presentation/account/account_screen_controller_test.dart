import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/presentation/account/account_screen_controller.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    late MockAuthRepository authRepository;
    late AccountScreenController controller;
    // this is called before each test
    setUp(() {
      authRepository = MockAuthRepository();
      controller = AccountScreenController(
        authRepository: authRepository,
      );
    });
    test('initial state is AsyncValue.data(null)', () {
      verifyNever(authRepository.signOut);
      expect(controller.state, const AsyncData<void>(null));
    });

    test(
      'signOut success',
      () async {
        // setup
        when(authRepository.signOut).thenAnswer((_) => Future.value());
        // expect later
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              const AsyncData<void>(null),
            ]));
        // run
        await controller.signOut();
        // verify
        verify(() => authRepository.signOut()).called(1);
        // expect(controller.state, const AsyncData<void>(null));
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      'signOut failure',
      () async {
        // setup
        final exception = Exception('Connection failed');
        when(authRepository.signOut).thenThrow(exception);
        // expect later
        expectLater(
            controller.stream,
            emitsInOrder([
              const AsyncLoading<void>(),
              predicate<AsyncValue<void>>((value) {
                expect(value.hasError, true);
                expect(value.error, exception);
                return true;
              }),
              // or
              // isA<AsyncError<void>>(),
              // or
              // predicate<AsyncValue<void>>((value) {
              //   return value is AsyncError && value.error == exception;
              // }),
            ]));
        // run
        await controller.signOut();
        // verify
        verify(() => authRepository.signOut()).called(1);
        // expect(controller.state.hasError, true);
        // or
        // expect(controller.state, isA<AsyncError<void>>());
        // or
        // expect(controller.state.error, exception);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
