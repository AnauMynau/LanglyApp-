import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // 1. Запрашиваем разрешение у пользователя (особенно важно для iOS и новых Android)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Пользователь разрешил пуш-уведомления');
    } else {
      debugPrint('Пользователь отклонил пуш-уведомления');
    }

    // 2. Получаем уникальный токен устройства (нужен для отправки тестового пуша из консоли)
    String? token = await _fcm.getToken();
    debugPrint('FCM Token: $token');

    // 3. Слушаем сообщения, когда приложение открыто (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Получено сообщение в открытом приложении: ${message.notification?.title}');
      // Здесь можно показать локальный Снекбар с текстом уведомления
    });
  }
}