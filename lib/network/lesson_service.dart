import 'package:chopper/chopper.dart';
import 'model_response.dart';
import 'service_interface.dart';
import '../models/lesson.dart';
import 'lesson_converter.dart';

part 'lesson_service.chopper.dart';

@ChopperApi()
abstract class LessonService extends ChopperService
    implements ServiceInterface {

  @override
  @Get(path: '')
  Future<LessonResponse> queryLessons();

  static LessonService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://gist.githubusercontent.com/AnauMynau/84d174e2b9583ec93ddf6ef89fe5710c/raw/864f9bacab19d843b8de3979808ca0183018c55f/lessons.json'),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
      converter: LessonConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$LessonService(),
      ],
    );
    return _$LessonService(client);
  }
}