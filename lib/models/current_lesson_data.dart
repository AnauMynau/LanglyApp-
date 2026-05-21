import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart'; // Добавили этот импорт для надежности
import 'lesson.dart';

part 'current_lesson_data.freezed.dart';

@freezed
class CurrentLessonData with _$CurrentLessonData {
  const factory CurrentLessonData({
    @Default(<Lesson>[]) List<Lesson> currentLessons,
    @Default(<String>[]) List<String> savedLessonIds,
  }) = _CurrentLessonData;
}