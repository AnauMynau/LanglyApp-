import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const String kUserLoggedIn = 'userLoggedIn';
  static const String kCurrentTab = 'currentTab';
  static const String kSearchHistory = 'searchHistory';
  static const String kSelectedLanguage = 'selectedLanguage';

  Future<void> cacheLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kSelectedLanguage, language);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kSelectedLanguage) ?? 'All';
  }

  Future<void> cacheUserLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kUserLoggedIn, isLoggedIn);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kUserLoggedIn) ?? false;
  }

  Future<void> cacheCurrentTab(int tabIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kCurrentTab, tabIndex);
  }

  Future<int> getCurrentTab() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(kCurrentTab) ?? 0;
  }

  Future<void> cacheSearchHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(kSearchHistory, history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(kSearchHistory) ?? <String>[];
  }
}