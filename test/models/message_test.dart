import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duoapp/models/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message Model Tests', () {

    test('can instantiate Message from JSON', () {
      final date = DateTime.now();

      final jsonMap = <String, dynamic>{
        'text': 'ninjaaa!',
        'date': Timestamp.fromDate(date),
        'email': 'ninja@dojo.com',
      };

      // 2. ACT
      final message = Message.fromJson(jsonMap);

      // 3. ASSERT
      expect(message, isNotNull);
      expect(message.text, equals('ninjaaa!'));
      expect(message.email, equals('ninja@dojo.com'));
      expect(message.date, equals(date));
    });

    test('can instantiate Message object', () {
      final date = DateTime.now();
      const text = 'Hello world!';
      const email = 'student@test.com';

      final message = Message(
        text: text,
        date: date,
        email: email,
      );

      expect(message, isNotNull);
      expect(message.text, equals('Hello world!'));
      expect(message.email, equals('student@test.com'));
    });

  });
}