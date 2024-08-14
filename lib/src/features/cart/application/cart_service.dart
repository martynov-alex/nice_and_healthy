import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/cart/data/local/local_cart_repository.dart';
import 'package:nice_and_healthy/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:nice_and_healthy/src/features/cart/domain/cart.dart';
import 'package:nice_and_healthy/src/features/cart/domain/item.dart';
import 'package:nice_and_healthy/src/features/cart/domain/mutable_cart.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

class CartService {
  CartService({
    required this.authRepository,
    required this.localCartRepository,
    required this.remoteCartRepository,
  });

  final FakeAuthRepository authRepository;
  final LocalCartRepository localCartRepository;
  final RemoteCartRepository remoteCartRepository;

  /// Add an item to the cart by *overriding* the quantity if it already exists.
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  /// Add an item to the cart by *updating* the quantity if it already exists.
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  /// Add a list of items to the cart by *updating* the quantities of items that
  /// already exist.
  Future<void> addItems(List<Item> items) async {
    final cart = await _fetchCart();
    final updated = cart.addItems(items);
    await _setCart(updated);
  }

  /// If an item with the given productId is found, remove it from the local or
  /// remote cart depending on the user auth state.
  Future<void> removeItemById(ProductID productId) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productId);
    await _setCart(updated);
  }

  /// Fetch the cart from the local or remote repository
  /// depending on the user auth state
  Future<Cart> _fetchCart() async {
    final user = authRepository.currentUser;
    return user == null
        ? localCartRepository.fetchCart()
        : remoteCartRepository.fetchCart(user.uid);
  }

  /// Save the cart to the local or remote repository
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = authRepository.currentUser;
    return user == null
        ? localCartRepository.setCart(cart)
        : remoteCartRepository.setCart(user.uid, cart);
  }
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(
    authRepository: ref.watch(authRepositoryProvider),
    localCartRepository: ref.watch(localCartRepositoryProvider),
    remoteCartRepository: ref.watch(remoteCartRepositoryProvider),
  );
});

final cartStreamProvider = StreamProvider<Cart>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  return user == null
      ? ref.watch(localCartRepositoryProvider).watchCart()
      : ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
});
