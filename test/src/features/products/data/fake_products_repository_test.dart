import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/constants/test_products.dart';
import 'package:nice_and_healthy/src/features/products/data/fake_products_repository.dart';

void main() {
  FakeProductsRepository makeFakeProductsRepository() =>
      FakeProductsRepository(addDelay: false);
  group('FakeProductsRepository', () {
    test('getProductsList returns global list', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    });

    test('getProduct(1) returns the first item', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        productsRepository.getProduct('1'),
        kTestProducts.first,
      );
    });

    test('getProduct(100) returns null', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        // We should use closure here because otherwise we will have
        // unhandled error
        // () => productsRepository.getProduct('100'),
        // If we use firstWhere() matcher should be 'throwsStateError'
        // because firstWhere() throw StateError if there is no element
        //throwsStateError,
        productsRepository.getProduct('100'),
        null,
      );
    });

    test('fetchProductsList returns global list', () async {
      final productsRepository = makeFakeProductsRepository();
      expect(
        await productsRepository.fetchProductsList(),
        kTestProducts,
      );
    });

    test('fetchProduct(1) returns the first item', () async {
      final productsRepository = makeFakeProductsRepository();
      expect(
        await productsRepository.fetchProduct('1'),
        kTestProducts.first,
      );
    });

    test('fetchProduct(100) returns null', () async {
      final productsRepository = makeFakeProductsRepository();
      expect(
        await productsRepository.fetchProduct('100'),
        null,
      );
    });

    test('watchProductsList emits global list', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        productsRepository.watchProductsList(),
        emits(kTestProducts),
      );
    });

    test('watchProduct(1) emits the first item', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        productsRepository.watchProduct('1'),
        emits(kTestProducts.first),
      );
    });

    test('watchProduct(100) emits null', () {
      final productsRepository = makeFakeProductsRepository();
      expect(
        productsRepository.watchProduct('100'),
        emits(null),
      );
    });
  });
}
