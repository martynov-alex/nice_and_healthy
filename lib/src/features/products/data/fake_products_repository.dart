import 'package:collection/collection.dart';
import 'package:nice_and_healthy/src/constants/test_products.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();

  static FakeProductsRepository instance = FakeProductsRepository._();

  List<Product> getProductsList() {
    return kTestProducts;
  }

  Product? getProduct(String id) {
    return kTestProducts.firstWhereOrNull((product) => product.id == id);
  }

  Future<List<Product>> fetchProducts() async {
    return Future.value(kTestProducts);
  }

  Future<Product> fetchProduct(String id) async {
    return Future.value(
        kTestProducts.firstWhere((product) => product.id == id));
  }

  Stream<List<Product>> watchProducts() {
    return Stream.value(kTestProducts);
  }

  Stream<Product> watchProduct(String id) {
    return Stream.value(
        kTestProducts.firstWhere((product) => product.id == id));
  }
}
