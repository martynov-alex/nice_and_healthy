// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nice_and_healthy/src/features/cart/domain/item.dart';
import 'package:nice_and_healthy/src/features/products/domain/product.dart';

/// Model class representing the shopping cart contents.
class Cart {
  const Cart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<ProductID, int> items;

  @override
  String toString() => 'Cart(items: $items)';

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return mapEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;

  Map<String, dynamic> toMap() => {'items': items};

  factory Cart.fromMap(Map<String, dynamic> map) =>
      Cart(Map<ProductID, int>.from(map['items']));

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}

extension CartItems on Cart {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
