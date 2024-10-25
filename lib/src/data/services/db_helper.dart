import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // create tablas
    await db.execute('''CREATE TABLE Users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      phone TEXT NOT NULL,
      password TEXT NOT NULL,
      signup_date TEXT NOT NULL
    )''');

    await db.execute('''CREATE TABLE Fields (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      location TEXT NOT NULL,
      opening_time TEXT NOT NULL,
      closing_time TEXT NOT NULL, 
      type TEXT NOT NULL
    )''');

    await db.execute('''CREATE TABLE Reservations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      field_id INTEGER NOT NULL,
      reservation_date TEXT NOT NULL,
      start_time TEXT NOT NULL,
      end_time TEXT NOT NULL,
      status TEXT NOT NULL,
      FOREIGN KEY(user_id) REFERENCES Users(id),
      FOREIGN KEY(field_id) REFERENCES Fields(id)
    )''');

    //add fields
    await db.insert('Fields', {
      'name': 'Epic Box',
      'location': 'Main Sports Center',
      'opening_time': '07:00',
      'closing_time': '17:00',
      'type': 'A'
    });
    await db.insert('Fields', {
      'name': 'Sport Box',
      'location': 'Main Sports Center',
      'opening_time': '07:00',
      'closing_time': '17:00',
      'type': 'C'
    });
    await db.insert('Fields', {
      'name': 'Multi Box',
      'location': 'Community Park',
      'opening_time': '07:00',
      'closing_time': '17:00',
      'type': 'A'
    });
  }

}
