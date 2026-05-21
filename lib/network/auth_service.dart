import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Проверка текущего пользователя
  User? get currentUser => _auth.currentUser;

  // Поток (Stream) для отслеживания статуса входа/выхода
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Регистрация нового пользователя
  Future<UserCredential?> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // Здесь можно добавить обработку ошибок (например, "Слишком слабый пароль")
      print('Ошибка регистрации: ${e.message}');
      return null;
    }
  }

  // Вход существующего пользователя
  Future<UserCredential?> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print('Ошибка входа: ${e.message}');
      return null;
    }
  }

  // Выход из аккаунта
  Future<void> logout() async {
    await _auth.signOut();
  }
}