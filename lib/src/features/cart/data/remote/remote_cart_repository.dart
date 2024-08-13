import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:nice_and_healthy/src/features/cart/domain/cart.dart';

/// API for reading, watching and writing cart data for a specific user ID
abstract class RemoteCartRepository {
  Future<Cart> fetchCart(String uid);

  Stream<Cart> watchCart(String uid);

  Future<void> setCart(String uid, Cart cart);
}

final remoteCartRepositoryProvider = Provider<RemoteCartRepository>((ref) {
  // TODO: replace with "real" remote cart repository
  return FakeRemoteCartRepository();
});
