import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'model_response.dart';
import '../models/lesson.dart';

class LessonConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
        request, contentTypeKey, jsonHeaders, override: false
    );
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    if (request.headers[contentTypeKey] == jsonHeaders) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    try {
      final body = utf8.decode(response.bodyBytes);
      final mapData = json.decode(body) as Map<String, dynamic>;

      final List<dynamic> jsonList = mapData['results'];
      final lessons = jsonList.map((json) => Lesson.fromJson(json)).toList();

      return response.copyWith<BodyType>(
        body: Success(lessons) as BodyType,
      );
    } catch (e) {
      return response.copyWith<BodyType>(
        body: Error(Exception(e.toString())) as BodyType,
      );
    }
  }
}