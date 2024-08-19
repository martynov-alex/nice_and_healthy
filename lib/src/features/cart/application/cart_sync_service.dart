import 'dart:developer';

import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/domain/app_user.dart';
import 'package:riverpod/riverpod.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }

  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(
      authStateChangesProvider,
      (previous, next) {
        final previousUser = previous?.value;
        final nextUser = next.value;

        if (previousUser == null && nextUser != null) {
          log('sign in: ${nextUser.uid}');
        }
      },
    );
  }
}

final cartSyncServiceProvider = Provider<CartSyncService>((ref) {
  return CartSyncService(ref);
});
