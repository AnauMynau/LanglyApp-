import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDao extends ChangeNotifier {
  // Получаем доступ к инструментам авторизации Firebase
  final auth = FirebaseAuth.instance;

  String errorMsg = 'An error has occurred.';

  // Проверка: вошел ли пользователь в систему
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  // Получить ID текущего пользователя
  String? userId() {
    return auth.currentUser?.uid;
  }

  // Получить email текущего пользователя
  String? email() {
    return auth.currentUser?.email;
  }

  // --- РЕГИСТРАЦИЯ ---
  Future<String?> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      // ВОТ ЗДЕСЬ МЫ ПРОСТО ВОЗВРАЩАЕМ РЕАЛЬНУЮ ОШИБКУ ОТ GOOGLE
      return e.message;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // --- ЛОГИН ---
  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (email.isEmpty) {
        errorMsg = 'Email is blank.';
      } else if (password.isEmpty) {
        errorMsg = 'Password is blank.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        errorMsg = 'Invalid credentials.';
      } else if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password provided for that user.';
      }
      return errorMsg;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  // --- ВЫХОД ИЗ АККАУНТА ---
  void logout() async {
    await auth.signOut();
    notifyListeners();
  }
}