import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  static Database? _database;

  LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'logs.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id TEXT,
            violation_type TEXT,
            timestamp TEXT,
            synced INTEGER DEFAULT 0
          )
        ''');
        await db.execute('''
          CREATE TABLE exam_keys (
            file_name TEXT PRIMARY KEY,
            encryption_key TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLog(String userId, String violationType) async {
    final db = await database;
    await db.insert('logs', {
      'user_id': userId,
      'violation_type': violationType,
      'timestamp': DateTime.now().toIso8601String(),
      'synced': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getUnsyncedLogs() async {
    final db = await database;
    return db.query('logs', where: 'synced = ?', whereArgs: [0]);
  }

  Future<void> markLogsAsSynced(List<int> logIds) async {
    final db = await database;
    await db.update('logs', {'synced': 1}, where: 'id IN (${logIds.join(",")})');
  }

  Future<void> saveEncryptionKey(String fileName, String key) async {
    final db = await database;
    await db.insert(
      'exam_keys',
      {'file_name': fileName, 'encryption_key': key},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getEncryptionKey(String fileName) async {
    final db = await database;
    final result = await db.query(
      'exam_keys',
      where: 'file_name = ?',
      whereArgs: [fileName],
    );
    if (result.isNotEmpty) {
      return result.first['encryption_key'] as String;
    }
    return null;
  }

}
