import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime date;
  final String? email;

  Message({
    required this.text,
    required this.date,
    this.email,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
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