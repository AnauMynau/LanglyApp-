import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../models/plan_item.dart'; // Твоя модель

part 'duo_db.g.dart'; // Обязательно с точкой с запятой в конце!

// ... дальше идет твой класс DbPlanItem extends Table ...
// 1. Описываем таблицу для наших запланированных уроков
class DbPlanItem extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get duration => text()(); // ДОБАВИЛИ duration
  IntColumn get intensity => integer()(); // ИЗМЕНИЛИ на integer()
  TextColumn get studentName => text()();

  BoolColumn get isSelfStudy => boolean()();
  DateTimeColumn get date => dateTime()();
}

// 1. DAO: Менеджер запросов для таблицы DbPlanItem
@DriftAccessor(tables: [DbPlanItem])
class PlanItemDao extends DatabaseAccessor<DuoDatabase>
    with _$PlanItemDaoMixin {
  final DuoDatabase db;
  PlanItemDao(this.db) : super(db);

  // Получить все уроки как Стрим (чтобы UI обновлялся сам, как в Главе 14)
  Stream<List<DbPlanItemData>> watchAllPlans() => select(dbPlanItem).watch();

  // Добавить новый урок в базу
  Future<int> insertPlan(
      Insertable<DbPlanItemData> item
      ) => into(dbPlanItem).insert(item);

  // Удалить урок по его ID
  Future<void> deletePlan(int id) =>
      (delete(dbPlanItem)..where((tbl) => tbl.id.equals(id))).go();
}

// 2. Функция для создания/открытия файла базы данных в памяти телефона
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'duo_app.sqlite'));
    return NativeDatabase(file);
  });
}

// 3. Главный класс базы данных
@DriftDatabase(tables: [DbPlanItem], daos: [PlanItemDao])
class DuoDatabase extends _$DuoDatabase {
  DuoDatabase() : super(_openConnection());

  // Версия базы данных (если позже добавишь новые колонки, поменяешь на 2)
  @override
  int get schemaVersion => 1;
}

// 1. Переводим данные из БД в формат приложения
PlanItem dbPlanItemToPlanItem(DbPlanItemData dbItem) {
  return PlanItem(
    id: dbItem.id.toString(), // В базе ID это int, а в UI это String. Переводим
    name: dbItem.name,
    duration: dbItem.duration, // Добавили
    intensity: dbItem.intensity,
    studentName: dbItem.studentName,
    isSelfStudy: dbItem.isSelfStudy,
    date: dbItem.date,
  );
}

// 2. Переводим данные из приложения в БД
Insertable<DbPlanItemData> planItemToInsertableDb(PlanItem item) {
  return DbPlanItemCompanion.insert(
    // id мы сюда не передаем, база данных сама назначит 1, 2, 3...
    name: item.name,
    duration: item.duration, // Добавили
    intensity: item.intensity,
    studentName: item.studentName,
    isSelfStudy: item.isSelfStudy,
    date: item.date,
  );
}
// TODO: Здесь мы позже добавим сам класс базы данных (@DriftDatabase)
// TODO: Здесь мы позже добавим DAO (Data Access Object)