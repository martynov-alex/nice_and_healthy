import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/constants/test_products.dart';
import 'package:nice_and_healthy/src/features/products/data/fake_products_repository.dart';

void main() {
  test('getProductsList returns global list', () {
    final productsRepository = FakeProductsRepository();
    expect(
      productsRepository.getProductsList(),
      kTestProducts,
    );
  });

  test('getProduct(1) returns the first item', () {
    final productsRepository = FakeProductsRepository();
    expect(
      productsRepository.getProduct('1'),
      kTestProducts.first,
    );
  });

  test('getProduct(100) returns null', () {
    final productsRepository = FakeProductsRepository();
    expect(
      // We should use closure here because otherwise we will have
      // unhandled error
      () => productsRepository.getProduct('100'),
      // If we use firstWhereOrNull() matcher could be null
      // null,
      // But if we use firstWhere() matcher should be 'throwsStateError'
      // because firstWhere() throw StateError if there is no element
      throwsStateError,
    );
  });
}
