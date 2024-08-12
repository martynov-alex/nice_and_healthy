const fakeRepositoriesDelayDurationInSeconds = 1;

Future<void> delay(
  bool addDelay, {
  int seconds = fakeRepositoriesDelayDurationInSeconds,
}) async =>
    addDelay ? Future.delayed(Duration(seconds: seconds)) : Future.value();
