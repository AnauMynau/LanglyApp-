import 'package:chopper/chopper.dart';
import 'model_response.dart';
import '../models/lesson.dart';

typedef LessonResponse = Response<Result<List<Lesson>>>;

abstract class ServiceInterface {
  Future<LessonResponse> queryLessons();
}