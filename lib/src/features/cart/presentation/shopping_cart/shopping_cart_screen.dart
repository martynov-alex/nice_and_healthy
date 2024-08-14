import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nice_and_healthy/src/common_widgets/async_value_widget.dart';
import 'package:nice_and_healthy/src/common_widgets/primary_button.dart';
import 'package:nice_and_healthy/src/features/cart/application/cart_service.dart';
import 'package:nice_and_healthy/src/features/cart/domain/cart.dart';
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
    // TODO: Error handling

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: Consumer(
        builder: (_, ref, __) {
          final cartValue = ref.watch(cartStreamProvider);

          return AsyncValueWidget<Cart>(
            value: cartValue,
            data: (cart) => ShoppingCartItemsBuilder(
              items: cart.toItemsList(),
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
        },
      ),
    );
  }
}
