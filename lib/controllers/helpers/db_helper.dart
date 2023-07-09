import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_flutter/modals/todo_convertor_modal.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper dataBaseHelper = DataBaseHelper._();
  Database? db;
  String dbName = 'db_todo';
  String tableName = 'tbl_todo';
  String Id = 'id';
  String Time = 'time';
  String Note = 'todos';

  void initDB() async {
    String directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            'CREATE TABLE IF NOT EXISTS $tableName($Id INTEGER PRIMARY KEY AUTOINCREMENT ,$Note TEXT ,$Time TEXT)';
        await db.execute(query);
      },
    );
  }

  void insertRecord({required String todo, required String time}) async {
    initDB();
    String query = 'INSERT INTO $tableName($Note,$Time)VALUES(?,?)';
    List arguments = [
      todo,
      time,
    ];
    int? id = await db?.rawInsert(query, arguments);
  }

  Future<List<TodoConvertor>> fetchAllRecodes() async {
    initDB();
    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<TodoConvertor> allData =
        data.map((e) => TodoConvertor.fromMap(data: e)).toList();
    return allData;
  }
}
