import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';
import 'package:nice_and_healthy/src/utils/in_memory_store.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  AppUser? get currentUser => _authState.value;

  Stream<AppUser?> authStateChanges() => _authState.stream;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Failed to sign in with email and password.');
    if (currentUser == null) _createNewUser(email);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception('Failed to sign in with email and password.');
    if (currentUser == null) _createNewUser(email);
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email) {
    final uid = email.split('').reversed.join();
    _authState.value = AppUser(uid: uid, email: email);
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final authRepo = FakeAuthRepository();
  ref.onDispose(() => authRepo.dispose());
  return authRepo;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return authRepository.authStateChanges();
});
