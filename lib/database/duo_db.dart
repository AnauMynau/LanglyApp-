import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/plan_item.dart';

part 'duo_db.g.dart';

class DbPlanItem extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get duration => text()();
  IntColumn get intensity => integer()();
  TextColumn get studentName => text()();

  BoolColumn get isSelfStudy => boolean()();
  DateTimeColumn get date => dateTime()();
}

@DriftAccessor(tables: [DbPlanItem])
class PlanItemDao extends DatabaseAccessor<DuoDatabase>
    with _$PlanItemDaoMixin {
  final DuoDatabase db;
  PlanItemDao(this.db) : super(db);

  Stream<List<DbPlanItemData>> watchAllPlans() => select(dbPlanItem).watch();

  Future<int> insertPlan(
      Insertable<DbPlanItemData> item
      ) => into(dbPlanItem).insert(item);

  Future<void> deletePlan(int id) =>
      (delete(dbPlanItem)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'duo_app.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [DbPlanItem], daos: [PlanItemDao])
class DuoDatabase extends _$DuoDatabase {
  DuoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

PlanItem dbPlanItemToPlanItem(DbPlanItemData dbItem) {
  return PlanItem(
    id: dbItem.id.toString(),
    name: dbItem.name,
    duration: dbItem.duration,
    intensity: dbItem.intensity,
    studentName: dbItem.studentName,
    isSelfStudy: dbItem.isSelfStudy,
    date: dbItem.date,
  );
}

Insertable<DbPlanItemData> planItemToInsertableDb(PlanItem item) {
  return DbPlanItemCompanion.insert(
    name: item.name,
    duration: item.duration,
    intensity: item.intensity,
    studentName: item.studentName,
    isSelfStudy: item.isSelfStudy,
    date: item.date,
  );
}
