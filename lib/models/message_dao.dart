import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class MessageDao {
  // Подключаемся к коллекции (папке) 'messages' в нашей базе данных Firestore.
  // Если такой коллекции еще нет, Firebase создаст её автоматически!
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('messages');

  // --- ЗАПИСЬ ---
  // Превращаем наш объект Message в JSON и закидываем в облако
  void saveMessage(Message message) {
    collection.add(message.toJson());
  }

  // --- ЧТЕНИЕ (РЕАЛЬНОЕ ВРЕМЯ) ---
  // Получаем поток всех сообщений, отсортированных по дате (самые новые сверху)
  Stream<QuerySnapshot> getMessageStream() {
    return collection.orderBy('date', descending: true).snapshots();
  }
}