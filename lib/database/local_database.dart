import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:synchronized/synchronized.dart';


class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  final _lock = Lock();
  static Database? _database;

  LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await _lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
      }
    });
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ueh.db');
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
          CREATE TABLE exam_table (
            exam_id TEXT PRIMARY KEY,
            file_data BLOB,
            answers TEXT
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


  Future<void> saveEncryptedFile(String examId, Uint8List fileData) async {
    final db = await database;
    await db.insert(
      'exam_table',
      {
        'exam_id': examId,
        'file_data': fileData,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Uint8List?> getEncryptedFile(String examId) async {
    final db = await database;
    final result = await db.query(
      'exam_table',
      columns: ['file_data'],
      where: 'exam_id = ?',
      whereArgs: [examId],
    );
    if (result.isNotEmpty) {
      final data = result.first['file_data'];
      if (data is Uint8List) {
        return data;
      }
    }
    return null;
  }



  Future<void> saveAnswer(String examId, int questionIndex, String answer) async {
    final db = await database;
    final result = await db.query(
      'exam_table',
      columns: ['answers'],
      where: 'exam_id = ?',
      whereArgs: [examId],
    );

    Map<int, String> answers = {};

    if (result.isNotEmpty) {
      final String storedAnswers = result.first['answers'] as String;
      answers = _parseAnswers(storedAnswers);
    }
    answers[questionIndex] = answer;

    await db.insert(
      'exam_table',
      {
        'exam_id': examId,
        'answers': jsonEncode(answers),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<int, String>> loadAnswers(String examId) async {
    final db = await database;
    final result = await db.query(
      'exam_table',
      where: 'exam_id = ?',
      whereArgs: [examId],
    );
    if (result.isNotEmpty) {
      String answersString = result.first['answers'] as String;
      return _parseAnswers(answersString);
    }
    return {};
  }

  Map<int, String> _parseAnswers(String jsonString) {
    if (jsonString.isEmpty) return {};
    try {
      Map<String, dynamic> decoded = jsonDecode(jsonString);
      return decoded.map<int, String>((key, value) => MapEntry(int.parse(key), value.toString()));
    } catch (e) {
      print("Error parsing answers: $e");
      return {};
    }
  }


  Future<bool> checkIsSaved(String examId) async {
    final db = await database;
    final result = await db.query(
      'exam_table',
      columns: ['file_data'],
      where: 'examId = ?',
      whereArgs: [examId],
    );

    if (result.isNotEmpty) {
      final file = result.first['file'];
      return file != null;
    }

    return false;
  }

}
