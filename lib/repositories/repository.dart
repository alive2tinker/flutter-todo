import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqlite/repositories/db_connection.dart';

class Repository {
  DBConnection _connection;

  Repository(){
    _connection = DBConnection();
  }

  static Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await _connection.setDatabase();

    return _database;
  }

  save(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }
  
  getAll(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  get(String table, categoryId) async {
    var conn = await database;
    return await conn.query(table, where: 'id=?', whereArgs: [categoryId]);
  }

  update(String table, data) async {
    var conn = await database;
    return await conn.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  destroy(String table, int id) async {
    var conn = await database;
    return await conn.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}