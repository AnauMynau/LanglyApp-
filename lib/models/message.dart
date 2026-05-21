import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text; // Текст сообщения
  final DateTime date; // Время отправки
  final String? email; // Кто отправил (email)

  Message({
    required this.text,
    required this.date,
    this.email,
  });

  // ЧТЕНИЕ ИЗ БАЗЫ: Превращаем JSON-документ из Firestore в объект Message
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
      // Внимание: Firestore хранит время в своем формате Timestamp,
      // поэтому нам нужно перевести его в привычный DateTime
      date: json['date'] != null
          ? (json['date'] as Timestamp).toDate()
          : DateTime.now(),
      email: json['email'],
    );
  }

  // ЗАПИСЬ В БАЗУ: Превращаем объект Message в JSON-словарь для сохранения
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date,
      'email': email,
    };
  }
}