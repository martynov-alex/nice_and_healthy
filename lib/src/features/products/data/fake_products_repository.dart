// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/constants/test_products.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';
import 'package:nice_and_healthy/src/utils/delay.dart';
import 'package:nice_and_healthy/src/utils/in_memory_store.dart';

class FakeProductsRepository {
  FakeProductsRepository({this.addDelay = true});

  final bool addDelay;

  /// Preload with the default list of products when the app starts
  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));

  List<Product> getProductsList() {
    return _products.value;
  }

  Product? getProduct(String id) {
    // Just for example of test approach we use firstWhere() instead
    // of firstWhereOrNull()
    // try {
    //   return _products.firstWhere((product) => product.id == id);
    // } catch (e) {
    //   return null;
    // }
    return _products.value.firstWhereOrNull((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await delay(addDelay);
    return Future.value(_products.value);
  }

  Future<Product?> fetchProduct(String id) async {
    await delay(addDelay);
    return Future.value(
        _products.value.firstWhereOrNull((product) => product.id == id));
  }

  Stream<List<Product>> watchProductsList() async* {
    await delay(addDelay);
    yield _products.value;
    // return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) async* {
    await delay(addDelay);
    yield _products.value.firstWhereOrNull((product) => product.id == id);
    // return Stream.value(_products.firstWhere((product) => product.id == id));
  }

  /// Update product or add a new one
  Future<void> setProduct(Product product) async {
    await delay(addDelay);
    final products = _products.value;
    final index = products.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      // if not found, add as a new product
      products.add(product);
    } else {
      // else, overwrite previous product
      products[index] = product;
    }

    _products.value = products;
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  // * Set addDelay to false for faster loading
  return FakeProductsRepository(addDelay: false);
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return productsRepository.fetchProductsList();
});

final productFutureProvider =
    FutureProvider.autoDispose.family<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProduct(id);
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return productsRepository.watchProductsList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  // // Example of cashing data:
  // // keep the provider alive when it's no longer used
  // final link = ref.keepAlive();
  // // use a timer to dispose it after 10 seconds
  // final timer = Timer(const Duration(seconds: 10), () {
  //   link.close();
  // });
  // // make sure the timer is cancelled when the provider state is disposed
  // ref.onDispose(() => timer.cancel());
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
