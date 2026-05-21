import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/memory_repository.dart';
import 'models/current_lesson_data.dart';
import 'models/plan_manager.dart';
import 'models/main_screen_state.dart';
import 'models/user_dao.dart';
import 'models/message_dao.dart';

final repositoryProvider = NotifierProvider<MemoryRepository,
    CurrentLessonData>(() {
  return MemoryRepository();
});

final planManagerProvider = ChangeNotifierProvider<PlanManager>((ref) {
  return PlanManager();
});

final bottomNavigationProvider = StateNotifierProvider<MainScreenStateProvider,
    MainScreenState>((ref) {
  return MainScreenStateProvider();
});

final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

final messageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao();
});

final tabIndexProvider = StateProvider<int>((ref) => 0);