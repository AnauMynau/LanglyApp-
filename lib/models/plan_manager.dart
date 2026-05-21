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

  Stream<List<PlanItem>> watchOrders() {
    return _dao.watchAllPlans().map((dbItems) {
      return dbItems.map((dbItem) => dbPlanItemToPlanItem(dbItem)).toList();
    });
  }

  Future<void> submitOrder(String name, bool isSelfStudy) async {
    if (_cartItems.isNotEmpty) {
      for (var item in _cartItems) {
        final finalizedItem = item.copyWith(
          studentName: name,
          isSelfStudy: isSelfStudy,
        );

        await _dao.insertPlan(planItemToInsertableDb(finalizedItem));
      }

      _cartItems.clear();
      _cartStreamController.sink.add(_cartItems);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cartStreamController.close();
    _db.close();
    super.dispose();
  }
}