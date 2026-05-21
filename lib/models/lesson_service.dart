import 'dart:convert';
import 'package:flutter/services.dart';
import 'lesson.dart';

class LessonService {
  // Асинхронная функция загрузки
  Future<List<Lesson>> loadLessons() async {
    // 1. Читаем текстовый JSON-файл из памяти телефона (assets)
    final String jsonString = await rootBundle.loadString('assets/lessons.json');

    // 2. Превращаем текст в формат Map (Словарь)
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // 3. Достаем массив уроков по ключу "results" (как в нашем JSON)
    final List<dynamic> jsonList = jsonMap['results'];

    // 4. САМАЯ ГЛАВНАЯ СТРОЧКА КНИГИ:
    // Проходимся по списку и превращаем каждый кусок JSON в объект Lesson
    return jsonList.map((json) => Lesson.fromJson(json)).toList();
  }
}