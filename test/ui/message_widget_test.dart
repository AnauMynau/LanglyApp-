import 'package:duoapp/models/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('MessageWidget renders correctly (Golden Test)', () {

    testWidgets(
        'Widget is successfully and shows text',
            (WidgetTester tester) async {
      const testText = 'Hello, this is a test message!';
      const testEmail = 'ninja@dojo.com';
      final testDate = DateTime.now();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MessageWidget(
              testText,
              testDate,
              testEmail,
            ),
          ),
        ),
      );

      final textFinder = find.text(testText);
      final emailFinder = find.text(testEmail);

      expect(textFinder, findsOneWidget);
      expect(emailFinder, findsOneWidget);
    });

    testGoldens(
        'MessageWidget renders correctly (Golden Test)', (tester) async {
      final builder = GoldenBuilder.grid(columns: 1, widthToHeightRatio: 3)
        ..addScenario(
          'simple message',
          MessageWidget(
              'this is a design test!',
              DateTime.now(), 'ninja@dojo.com'
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      await screenMatchesGolden(tester, 'message_widget_light');
    });

  });
}