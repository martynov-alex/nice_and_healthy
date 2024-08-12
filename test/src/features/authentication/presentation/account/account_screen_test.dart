import 'package:flutter_test/flutter_test.dart';

import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    final r = AuthRobot(tester);
    // pump screen
    await r.pumpAccountScreen();
    // find logout button and tap it
    await r.tapLogoutButton();
    // expect that the logout dialog is presented
    r.expectLogoutDialogFound();
    // find cancel button and tap it
    await r.tapCancelButton();
    // expect that the logout dialog is no longer visible
    r.expectLogoutDialogNotFound();
  });
}
