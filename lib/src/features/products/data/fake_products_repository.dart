import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/constants/test_products.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

class FakeProductsRepository {
  final _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhereOrNull((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Future<Product?> fetchProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(
        _products.firstWhereOrNull((product) => product.id == id));
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
    // return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products.firstWhereOrNull((product) => product.id == id);
    // return Stream.value(_products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
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

final productStreamProvider =
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
