import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/common_widgets/primary_button.dart';
import 'package:nice_and_healthy/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:nice_and_healthy/src/localization/string_hardcoded.dart';
import 'package:nice_and_healthy/src/utils/async_value_ui.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      paymentButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(paymentButtonControllerProvider);
    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed: state.isLoading
          ? null
          : () => ref.read(paymentButtonControllerProvider.notifier).pay(),
    );
  }
}
