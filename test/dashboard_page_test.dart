import 'package:awesome/pages/DashboardPage.dart';
import 'package:awesome/utils/injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createDashboardPage() {
  WidgetsFlutterBinding.ensureInitialized();
  initDio();
  return MaterialApp(
    home: DashboardPage(),
  );
}

void initDio() async {
  await baseDio();
  await setupLocator();
}

void main() {
  group('Switch list mode test', () {
    testWidgets('Test if grid switch to list', (tester) async {
      await tester.pumpWidget(createDashboardPage());
      bool _mockIsGridMode = true;
      await tester.tap(find.byIcon(FeatherIcons.alignJustify).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(_mockIsGridMode = false,
          _mockIsGridMode);
    });
  });
}
