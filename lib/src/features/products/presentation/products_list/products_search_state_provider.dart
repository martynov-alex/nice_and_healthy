import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/features/products/data/fake_products_repository.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

final productsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

final productsSearchResultsProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final searchQuery = ref.watch(productsSearchQueryStateProvider);
  return ref.watch(productsListSearchProvider(searchQuery).future);
});
