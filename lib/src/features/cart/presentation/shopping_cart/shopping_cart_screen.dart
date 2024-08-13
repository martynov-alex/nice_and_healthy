import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nice_and_healthy/src/common_widgets/primary_button.dart';
import 'package:nice_and_healthy/src/features/cart/domain/item.dart';
import 'package:nice_and_healthy/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:nice_and_healthy/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:nice_and_healthy/src/localization/string_hardcoded.dart';
import 'package:nice_and_healthy/src/routing/app_router.dart';

/// Shopping cart screen showing the items in the cart (with editable
/// quantities) and a button to checkout.
class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    // TODO: Error handling
    const cartItemsList = [
      Item(
        productId: '1',
        quantity: 1,
      ),
      Item(
        productId: '2',
        quantity: 2,
      ),
      Item(
        productId: '3',
        quantity: 3,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: ShoppingCartItemsBuilder(
        items: cartItemsList,
        itemBuilder: (_, item, index) => ShoppingCartItem(
          item: item,
          itemIndex: index,
        ),
        ctaBuilder: (_) => PrimaryButton(
          text: 'Checkout'.hardcoded,
          onPressed: () => context.goNamed(AppRoute.checkout.name),
        ),
      ),
    );
  }
}
