import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'app_cache.dart';
import 'lesson.dart';
import '../network/lesson_service.dart';
import '../network/model_response.dart';

class AppStateManager extends ChangeNotifier {
  final AppCache _appCache = AppCache();
  final LessonService _lessonService;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  List<Lesson> _lessons = [];
  List<Lesson> get lessons => _lessons;

  String _selectedLanguage = 'All';
  String get selectedLanguage => _selectedLanguage;

  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  final Set<String> _favoriteLessons = {};
  Set<String> get favoriteLessons => _favoriteLessons;

  bool _isLoggedIn = false;
  String _username = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  AppStateManager(this._lessonService) {
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    _isLoggedIn = await _appCache.isUserLoggedIn();
    _selectedTab = await _appCache.getCurrentTab();
    _selectedLanguage = await _appCache.getLanguage();

    final savedHistory = await _appCache.getSearchHistory();
    _searchHistory = List<String>.from(savedHistory);

    try {
      final response = await _lessonService.queryLessons();
      if (response.isSuccessful) {
        final result = response.body;
        if (result is Success<List<Lesson>>) {
          _lessons = result.value;
        }
      } else {
        debugPrint('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Network error: $e');
    }

    _isInitialized = true;
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteLessons.contains(id);
  }

  void addSearchTerm(String term) async {
    if (term.isEmpty) return;
    if (!_searchHistory.contains(term)) {
      _searchHistory.insert(0, term);
      await _appCache.cacheSearchHistory(_searchHistory);
      notifyListeners();
    }
  }

  void removeSearchTerm(String term) async {
    _searchHistory.remove(term);
    await _appCache.cacheSearchHistory(_searchHistory);
    notifyListeners();
  }

  void changeLanguage(String language) async {
    _selectedLanguage = language;
    await _appCache.cacheLanguage(language);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (_favoriteLessons.contains(id)) {
      _favoriteLessons.remove(id);
    } else {
      _favoriteLessons.add(id);
    }
    notifyListeners();
  }

  void goToTab(int index) async {
    _selectedTab = index;
    await _appCache.cacheCurrentTab(index);
    notifyListeners();
  }

  void goToLessons() async {
    _selectedTab = 1;
    await _appCache.cacheCurrentTab(1);
    notifyListeners();
  }

  void login(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _username = username;
      await _appCache.cacheUserLoggedIn(true);
      notifyListeners();
    }
  }

  void logout() async {
    _isLoggedIn = false;
    _username = '';

    await _appCache.cacheUserLoggedIn(false);

    _selectedTab = 0;
    await _appCache.cacheCurrentTab(0);

    notifyListeners();
  }
}