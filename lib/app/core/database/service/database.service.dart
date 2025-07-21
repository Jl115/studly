import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'setuply.db');

    // reset db
    // await deleteDatabase(path);

    print('\x1B[32m dbPath :D -------------------- ${path}\x1B[0m');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        logged_in INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE setting(
        user_id TEXT PRIMARY KEY,
        dark_mode INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
      )
    ''');

    const uuid = Uuid();
    final newUserId = uuid.v4();

    await db.insert('user', {'id': newUserId, 'username': 'user', 'password': 'user'});

    await db.insert('setting', {'user_id': newUserId, 'dark_mode': 0});
  }
}
