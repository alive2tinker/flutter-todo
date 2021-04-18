import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DBConnection{
   setDatabase() async
  {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'sqflite_todos');
    var database = openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async{
    await db.execute("CREATE TABLE categories (id INTEGER PRIMARY KEY,name varchar(255),description TEXT)");
  }
}