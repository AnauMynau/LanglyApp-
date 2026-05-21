import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. ДОБАВИЛИ ИМПОРТ FIREBASE

import '../screens/not_found_screen.dart';
import '../home.dart';
// 2. УБЕДИСЬ, ЧТО ПУТЬ ВЕДЕТ К ТВОЕМУ НОВОМУ ЭКРАНУ ЛОГИНА (login.dart)
import '../components/login.dart';
import '../screens/lesson_details_screen.dart';
import '../models/app_state_manager.dart';
import '../models/plan_manager.dart';

class AppRouter {
  static GoRouter createRouter(
      AppStateManager appState,
      VoidCallback onThemeToggle,
      ) {
    return GoRouter(
      initialLocation: '/login',
      refreshListenable: appState,
      errorBuilder: (context, state) => const NotFoundScreen(),

      redirect: (context, state) {
        if (!appState.isInitialized) return null;

        // 3. БЕРЕМ СТАТУС АВТОРИЗАЦИИ НАПРЯМ УЮ ИЗ ОБЛАКА!
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        final isLoggingIn = state.matchedLocation == '/login';

        if (!loggedIn && !isLoggingIn) return '/login';

        if (loggedIn && (isLoggingIn || state.matchedLocation == '/')) {
          if (appState.selectedTab == 1) {
            return '/lessons';
          } else if (appState.selectedTab == 2) {
            return '/profile';
          } else {
            return '/learn';
          }
        }
        return null;
      },

      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        // --- ВОТ ЭТОТ КУСОК НУЖНО ДОБАВИТЬ ---
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) => NoTransitionPage(
            key: const ValueKey('chat-tab'),
            child: Home(onThemeToggle: onThemeToggle, currentTab: 3),
          ),
        ),
        // ------------------------------------
        GoRoute(
          path: '/lessons',
          pageBuilder: (context, state) => NoTransitionPage(
            key: const ValueKey('lessons-tab'),
            child: Home(onThemeToggle: onThemeToggle, currentTab: 1),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => NoTransitionPage(
            key: const ValueKey('profile-tab'),
            child: Home(onThemeToggle: onThemeToggle, currentTab: 2),
          ),
        ),
        GoRoute(
          path: '/learn',
          pageBuilder: (context, state) => NoTransitionPage(
            key: const ValueKey('learn-tab'),
            child: Home(onThemeToggle: onThemeToggle, currentTab: 0),
          ),
          routes: [
            GoRoute(
              path: ':id',
              pageBuilder: (context, state) {
                final itemId = state.pathParameters['id'];
                final selectedLesson = appState.lessons.firstWhere(
                      (lesson) => lesson.id == itemId,
                );
                final planManager = Provider.of<PlanManager>(
                    context, listen: false
                );

                return CustomTransitionPage(
                  key: state.pageKey,
                  child: LessonDetailsScreen(
                    lesson: selectedLesson,
                  ),
                  transitionDuration: const Duration(milliseconds: 600),
                  transitionsBuilder: (
                      context, animation, secondaryAnimation, child
                      )
                  {
                    return FadeTransition(
                      opacity: CurveTween(
                          curve: Curves.easeInOut
                      ).animate(animation),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}