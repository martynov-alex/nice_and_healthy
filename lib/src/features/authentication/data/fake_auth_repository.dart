import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';

class FakeAuthRepository {
  AppUser? get currentUser => null;

  Stream<AppUser?> authStateChanges() {
    // TODO(martynov): Update
    return Stream.value(null);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO(martynov): Implement
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO(martynov): Implement
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO(martynov): Implement
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return authRepository.authStateChanges();
});
