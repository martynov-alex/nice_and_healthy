import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nice_and_healthy/src/features/account/account_screen.dart';
import 'package:nice_and_healthy/src/features/orders_list/orders_list_screen.dart';
import 'package:nice_and_healthy/src/features/products_list/products_list_screen.dart';
import 'package:nice_and_healthy/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:nice_and_healthy/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:nice_and_healthy/src/features/sign_in/email_password_sign_in_state.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
        ),
        GoRoute(
          path: 'orders',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
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
