import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as p;

import '../components/lesson_list_view.dart';
import '../screens/checkout_screen.dart';
import '../screens/plan_screen.dart';
import '../screens/profile_screen.dart';
import '../providers.dart';
import '../models/app_state_manager.dart';
import 'models/message_list.dart';

class Home extends ConsumerWidget {
  final VoidCallback onThemeToggle;
  final int currentTab;

  const Home({
    super.key,
    required this.onThemeToggle,
    this.currentTab = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = p.Provider.of<AppStateManager>(context);
    final jsonLessons = appState.lessons;

    List<Widget> pages = [
      LessonListView(
        lessons: jsonLessons,
        onThemeToggle: onThemeToggle,
      ),
      const PlanScreen(),
      const ProfileScreen(),
      const MessageList(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: pages,
      ),
      endDrawer: const CheckoutScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (index) {
          if (index == 0) context.go('/learn');
          if (index == 1) context.go('/lessons');
          if (index == 2) context.go('/profile');
          if (index == 3) context.go('/chat');
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.explore_rounded
              ),
              label: 'Learn'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.assignment_rounded
              ),
              label: 'Lessons'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.person_rounded
              ),
              label: 'Profile'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.chat_rounded
              ),
              label: 'Chat'
          ),
        ],
      ),
    );
  }
}