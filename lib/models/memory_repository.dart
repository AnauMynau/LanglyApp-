import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'current_lesson_data.dart';
import 'lesson.dart';

class MemoryRepository extends Notifier<CurrentLessonData> {

  @override
  CurrentLessonData build() {
    return const CurrentLessonData();
  }

  void setLessons(List<Lesson> lessons) {
    state = state.copyWith(currentLessons: lessons);
  }

  void addSavedLesson(String lessonId) {
    if (!state.savedLessonIds.contains(lessonId)) {
      state = state.copyWith(
        savedLessonIds: [...state.savedLessonIds, lessonId],
      );
    }
  }

  void removeSavedLesson(String lessonId) {
    final updatedList = [...state.savedLessonIds];
    updatedList.remove(lessonId);
    state = state.copyWith(savedLessonIds: updatedList);
  }
}

final repositoryProvider = NotifierProvider<MemoryRepository,
    CurrentLessonData>(() {
  return MemoryRepository();
});