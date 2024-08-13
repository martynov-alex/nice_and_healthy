import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:nice_and_healthy/src/app.dart';

import '../../robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>({
    const Size(300, 600),
    const Size(600, 800),
    const Size(1000, 1000),
  });
  testWidgets(
    'Golden — product list',
    (tester) async {
      final r = Robot(tester);
      final currentSize = sizeVariant.currentValue!;
      await r.golden.setSurfaceSize(currentSize);
      await r.golden.loadRobotoFont();
      await r.golden.loadMaterialIconFont();
      await r.pumpMyApp();
      await r.golden.precacheImages();

      final goldenFileKey =
          'goldens/products_list_${currentSize.width.toInt()}x${currentSize.height.toInt()}.png';
      await expectLater(find.byType(MyApp), matchesGoldenFile(goldenFileKey));
    },
    variant: sizeVariant,
    tags: ['golden', 'products_list'],
  );
}
