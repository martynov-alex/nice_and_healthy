import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nice_and_healthy/src/features/account/account_screen.dart';
import 'package:nice_and_healthy/src/features/orders_list/orders_list_screen.dart';
import 'package:nice_and_healthy/src/features/product_page/product_screen.dart';
import 'package:nice_and_healthy/src/features/products_list/products_list_screen.dart';
import 'package:nice_and_healthy/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:nice_and_healthy/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:nice_and_healthy/src/features/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  product,
  cart,
  orders,
  account,
  signIn,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductScreen(productId: productId);
          },
        ),
        GoRoute(
          path: 'cart',
          name: AppRoute.cart.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
        ),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
);
