import 'dart:convert';
import 'package:flutter/services.dart';
import 'lesson.dart';

class LessonService {
  Future<List<Lesson>> loadLessons() async {
    final String jsonString = await rootBundle.loadString('assets/lessons.json');

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    final List<dynamic> jsonList = jsonMap['results'];

    return jsonList.map((json) => Lesson.fromJson(json)).toList();
  }
}