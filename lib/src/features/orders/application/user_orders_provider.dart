import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/orders/data/fake_orders_repository.dart';
import 'package:nice_and_healthy/src/features/orders/domain/order.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

/// Watch the list of user orders
/// NOTE: Only watch this provider if the user is signed in.
final userOrdersProvider = StreamProvider.autoDispose<List<Order>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(ordersRepositoryProvider).watchUserOrders(user.uid);
  } else {
    // If the user is null, return an empty list (no orders)
    return Stream.value([]);
  }
});

/// Check if a product was previously purchased by the user
final matchingUserOrdersProvider =
    StreamProvider.autoDispose.family<List<Order>, ProductID>((ref, productId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref
        .watch(ordersRepositoryProvider)
        .watchUserOrders(user.uid, productId: productId);
  } else {
    // If the user is null, return an empty list (no orders)
    return Stream.value([]);
  }
});
