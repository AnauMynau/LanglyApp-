import 'package:duoapp/components/card1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart' as old_provider;
import 'package:duoapp/models/app_state_manager.dart';
import 'package:duoapp/network/lesson_service.dart';

void main() {
  testWidgets('The heart button changes the icon when pressed',
          (WidgetTester tester) async {

    final lessonService = LessonService.create();
    final appStateManager = AppStateManager(lessonService);

    await tester.pumpWidget(
      old_provider.ChangeNotifierProvider.value(
        value: appStateManager,
        child: const MaterialApp(
          home: Scaffold(
            body: AnimatedHeartButton(lessonId: 'test_1'),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}