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
}
