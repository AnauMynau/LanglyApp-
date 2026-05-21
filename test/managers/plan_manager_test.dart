import 'package:duoapp/models/plan_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:duoapp/models/plan_item.dart';
import 'package:duoapp/database/duo_db.dart';
import 'plan_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PlanItemDao>()])
void main() {
  group('PlanManager Tests', () {

    test('submitOrder save to database', () async {
      // --- 1. ARRANGE  ---
      final mockDao = MockPlanItemDao();
      final manager = PlanManager(dao: mockDao);

      final testItem = PlanItem(
        id: '1',
        name: 'Test Lesson',
        duration: '10 min',
        intensity: 1,
        studentName: '',
        isSelfStudy: false,
        date: DateTime.now(),
      );
      await manager.addToCart(testItem);

      await manager.submitOrder('Ninja Student', true);

      // --- 3. ASSERT  ---
      verify(mockDao.insertPlan(any)).called(1);

      expect(manager.cartItems.isEmpty, true);
    });

  });
}