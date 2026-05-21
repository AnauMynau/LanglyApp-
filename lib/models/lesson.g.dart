// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imagePath: json['imagePath'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'description': instance.description,
      'category': instance.category,
      'imagePath': instance.imagePath,
      'exercises': instance.exercises,
      'language': instance.language,
    };

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      title: json['title'] as String,
      duration: json['duration'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'title': instance.title,
      'duration': instance.duration,
      'content': instance.content,
    };
