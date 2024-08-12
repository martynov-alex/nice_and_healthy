import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/common_widgets/alert_dialogs.dart';
import 'package:nice_and_healthy/src/features/authentication/data/fake_auth_repository.dart';
import 'package:nice_and_healthy/src/features/authentication/presentation/account/account_screen.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null)
            authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }

  Future<void> tapDialogLogoutButton() async {
    final logoutButton = find.byKey(alertDialogDefaultKey);
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  // * or
  // Future<void> tapDialogLogoutButton() async {
  //   final logoutButton = find.descendant(
  //     of: find.byType(Dialog),
  //     matching: find.text('Logout'),
  //   );
  //   expect(logoutButton, findsOneWidget);
  //   await tester.tap(logoutButton);
  //   await tester.pumpAndSettle();
  // }

  void expectErrorAlertFound() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsNothing);
  }

  void expectCircularProgressIndicatorFound() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
  }
}
