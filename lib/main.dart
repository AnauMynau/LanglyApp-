import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' as p;
import 'package:logging/logging.dart';
import 'models/app_cache.dart';
import 'network/push_notification_service.dart';
import 'theme/langly_theme.dart';
import 'navigation/app_router.dart';
import 'models/app_state_manager.dart';
import 'models/plan_manager.dart';
import 'package:duoapp/network/lesson_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pushService = PushNotificationService();
  await pushService.initialize();

  _setupLogging();
  final appCache = AppCache();
  final lessonService = LessonService.create();

  runApp(
    ProviderScope(
      child: p.MultiProvider(
        providers: [
          p.ChangeNotifierProvider(
              create: (context) => AppStateManager(lessonService)
          ),
          p.ChangeNotifierProvider(create: (context) => PlanManager()),
          p.Provider<AppCache>.value(value: appCache),
          p.Provider<LessonService>.value(value: lessonService),
        ],
        child: const DuoApp(),
      ),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class DuoApp extends StatefulWidget {
  const DuoApp({super.key});

  @override
  State<DuoApp> createState() => _DuoAppState();
}

class _DuoAppState extends State<DuoApp> {
  ThemeMode _themeMode = ThemeMode.light;

  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final appState = p.Provider.of<AppStateManager>(context, listen: false);

    _router = AppRouter.createRouter(appState, _toggleTheme);
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light)
          ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Langly',
      theme: LanglyTheme.light(),
      darkTheme: LanglyTheme.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

