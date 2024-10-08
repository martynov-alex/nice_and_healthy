import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/features/orders/presentation/orders_list/order_card.dart';

class OrdersRobot {
  OrdersRobot(this.tester);
  final WidgetTester tester;

  void expectFindZeroOrders() {
    final finder = find.byType(OrderCard);
    expect(finder, findsNothing);
  }

  void expectFindNOrders(int count) {
    final finder = find.byType(OrderCard);
    expect(finder, findsNWidgets(count));
  }
}
