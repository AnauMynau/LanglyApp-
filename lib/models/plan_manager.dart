import 'dart:async';
import 'package:flutter/material.dart';
import 'plan_item.dart';
import '../database/duo_db.dart';

class PlanManager extends ChangeNotifier {
  final List<PlanItem> _cartItems = [];

  late DuoDatabase _db;
  late PlanItemDao _dao;

  final StreamController<List<PlanItem>> _cartStreamController =
  StreamController<List<PlanItem>>.broadcast();

  PlanManager({PlanItemDao? dao}) {
    if (dao != null) {
      _dao = dao;
    } else {
      _db = DuoDatabase();
      _dao = _db.planItemDao;
    }

    _cartStreamController.onListen = () {
      _cartStreamController.sink.add(_cartItems);
    };
  }
  List<PlanItem> get cartItems => List.unmodifiable(_cartItems);
  Stream<List<PlanItem>> watchCartItems() => _cartStreamController.stream;

  Future<void> addToCart(PlanItem item) async {
    _cartItems.add(item);
    _cartStreamController.sink.add(_cartItems);
    notifyListeners();
  }

  Future<void> removeFromCart(int index) async {
    _cartItems.removeAt(index);
    _cartStreamController.sink.add(_cartItems);
    notifyListeners();
  }

  // --- МЕТОДЫ БАЗЫ ДАННЫХ (Работают с памятью телефона) ---

  // 4. Берем подтвержденные планы напрямую из БД!
  Stream<List<PlanItem>> watchOrders() {
    return _dao.watchAllPlans().map((dbItems) {
      // Конвертируем каждый элемент из формата базы в формат UI
      return dbItems.map((dbItem) => dbPlanItemToPlanItem(dbItem)).toList();
    });
  }

  // 5. Сохраняем оформленный план в БД
  Future<void> submitOrder(String name, bool isSelfStudy) async {
    if (_cartItems.isNotEmpty) {
      for (var item in _cartItems) {
        // Добавляем имя и формат к уроку
        final finalizedItem = item.copyWith(
          studentName: name,
          isSelfStudy: isSelfStudy,
        );

        // Переводим в формат БД и вставляем в таблицу!
        await _dao.insertPlan(planItemToInsertableDb(finalizedItem));
      }

      // Очищаем локальную корзину
      _cartItems.clear();
      _cartStreamController.sink.add(_cartItems);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cartStreamController.close();
    _db.close(); // 6. Обязательно закрываем соединение с БД при выходе
    super.dispose();
  }
}