import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  final String id;
  final String title;
  final String duration;
  final String description;
  final String category;
  final String imagePath;
  final List<Exercise> exercises;
  final String language;

  Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.exercises,
    required this.language,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable()
class Exercise {
  final String title;
  final String duration;
  final String content;

  Exercise({
    required this.title,
    required this.duration,
    required this.content,
  });

  factory Exercise.fromJson(
      Map<String, dynamic> json
      ) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}