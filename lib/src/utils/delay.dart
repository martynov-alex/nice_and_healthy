Future<void> delay(
  bool addDelay, {
  int milliseconds = 2000,
}) async =>
    addDelay
        ? Future.delayed(Duration(milliseconds: milliseconds))
        : Future.value();
