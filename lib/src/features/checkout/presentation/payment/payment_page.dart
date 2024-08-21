import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/common_widgets/async_value_widget.dart';
import 'package:nice_and_healthy/src/features/cart/application/cart_service.dart';
import 'package:nice_and_healthy/src/features/cart/domain/cart.dart';
import 'package:nice_and_healthy/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:nice_and_healthy/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:nice_and_healthy/src/features/checkout/presentation/payment/payment_button.dart';

/// Payment screen showing the items in the cart (with read-only quantities) and
/// a button to checkout.
class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartValue = ref.watch(cartProvider);

    return AsyncValueWidget<Cart>(
      value: cartValue,
      data: (cart) {
        return ShoppingCartItemsBuilder(
          items: cart.toItemsList(),
          itemBuilder: (_, item, index) => ShoppingCartItem(
            item: item,
            itemIndex: index,
            isEditable: false,
          ),
          ctaBuilder: (_) => const PaymentButton(),
        );
      },
    );
  }
}
