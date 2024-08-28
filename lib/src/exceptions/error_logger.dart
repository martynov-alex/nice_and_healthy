import 'dart:developer';

import 'package:riverpod/riverpod.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    // * This can be replaced with a call to a crash reporting tool of choice.
    log('$error, $stackTrace', name: 'error_logger');
  }
}

final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});
