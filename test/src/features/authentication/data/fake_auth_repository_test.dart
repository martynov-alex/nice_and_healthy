import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';

void main() {
  const testEmail = 'test@test';
  const testPassword = '1234';
  final testUser = AppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
  );

  FakeAuthRepository makeFakeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group('FakeAuthRepository', () {
    test('currentUser is null after initialization', () {
      final authRepository = makeFakeAuthRepository();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });
    test('current user is not null after sign in', () async {
      final authRepository = makeFakeAuthRepository();
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });
    test('current user is not null after registration', () async {
      final authRepository = makeFakeAuthRepository();
      await authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword);
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });
    test('current user is null after sign out', () async {
      final authRepository = makeFakeAuthRepository();
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      // we can use emitsInOrder like below
      // we move expect before signOut() because of emits order
      // expect(
      //   authRepository.authStateChanges(),
      //   emitsInOrder([
      //     testUser, // after signIn
      //     null, // after signOut
      //   ]),
      // );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
      await authRepository.signOut();
      expect(authRepository.currentUser, null);
      expect(authRepository.currentUser, null);
    });
    test('sign in after dispose throws exception', () {
      final authRepository = makeFakeAuthRepository();
      authRepository.dispose();
      expect(
        () =>
            authRepository.signInWithEmailAndPassword(testEmail, testPassword),
        throwsStateError,
      );
    });
  });
}
