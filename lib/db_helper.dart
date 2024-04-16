import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //static final DBHelper instance = DBHelper._privateConstructor();
  static const _databaseName = "names_db.db";
  static const _databaseVersion = 1;

  static const table = 'names_table';

  static const colId = 'id';
  static const colFirstName = 'first_name';
  static const colLastName = 'last_name';

  // make this a singleton class
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database?> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $table ('
            '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
            '$colFirstName TEXT NOT NULL,'
            '$colLastName TEXT NOT NULL'
            ')
        ''');
  }
}
