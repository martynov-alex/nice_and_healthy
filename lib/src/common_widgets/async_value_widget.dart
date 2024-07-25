import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nice_and_healthy/src/common_widgets/error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace)? error;
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error:
          error ?? (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading:
          loading ?? () => const Center(child: CircularProgressIndicator()),
    );
  }
}
