import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/cart/application/cart_service.dart';
import 'package:nice_and_healthy/src/features/cart/domain/item.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

class ShoppingCartScreenController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartScreenController({required this.cartService})
      : super(const AsyncValue.data(null));

  final CartService cartService;

  Future<void> updateItemQuantity(ProductID productId, int quantity) async {
    state = const AsyncLoading();
    final updated = Item(productId: productId, quantity: quantity);
    state = await AsyncValue.guard(() => cartService.setItem(updated));
  }

  Future<void> removeItemById(ProductID productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.removeItemById(productId));
  }
}

final shoppingCartScreenControllerProvider =
    StateNotifierProvider<ShoppingCartScreenController, AsyncValue<void>>(
        (ref) {
  final cartService = ref.watch(cartServiceProvider);
  return ShoppingCartScreenController(cartService: cartService);
});
