import 'package:duoapp/components/lesson_list_view.dart';
import 'package:duoapp/network/lesson_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as old_provider;
import 'package:duoapp/models/lesson.dart';
import 'package:duoapp/models/app_state_manager.dart';


void main() {
  testWidgets('Checking the display of the main screen LessonListView',
          (WidgetTester tester) async {

    final testLessons = <Lesson>[];

    await tester.pumpWidget(
      ProviderScope(
        child: old_provider.ChangeNotifierProvider(
          create: (_) => AppStateManager(LessonService.create()),
          child: MaterialApp(
            home: LessonListView(
              lessons: testLessons,
              onThemeToggle: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 150));
    await tester.pumpAndSettle();

    expect(find.text('Langly'), findsOneWidget);
    expect(find.text('Search courses (e.g. Grammar)'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
  });
}