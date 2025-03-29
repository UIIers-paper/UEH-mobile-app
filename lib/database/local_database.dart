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
            exam_id TEXT,
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

  Future<void> insertLog(String userId, String violationType, String examId) async {
    final db = await database;
    await db.insert('logs', {
      'user_id': userId,
      'exam_id': examId, 
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
      print("Data loaded: $data");
      if (data is Uint8List) {
        print("Data loaded: ${data.length}");
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
      String? answersString = result.first['answers'] as String?;
      if (answersString !=null){
        return _parseAnswers(answersString);

      }

    }
    return {};
  }

  Future<List<Map<String, dynamic>>> getSyncedAnswers() async {
  try {
    final db = await database;
    List<Map<String, dynamic>> syncedLogs = await db.query(
      'exam_table',
      where: 'synced = ?',
      whereArgs: [1],
    );

    if (syncedLogs.isEmpty) {
      print("Không có logs đã đồng bộ.");
      return [];
    }

    // Bước 2: Tạo danh sách kết quả
    List<Map<String, dynamic>> syncedAnswers = [];

    for (var log in syncedLogs) {
      String? examId = log['exam_id'];
      String? userId = log['user_id'];

      if (examId == null || examId.isEmpty) {
        print("Log không có exam_id: ${log['id']}");
        continue; 
      }
      final result = await db.query(
        'exam_table',
        columns: ['answers'],
        where: 'exam_id = ?',
        whereArgs: [examId],
      );

      if (result.isEmpty) {
        print("Không tìm thấy answers cho exam_id: $examId");
        continue; 
      }

      String? answersString = result.first['answers'] as String?;
      Map<int, String> answers = {};

      if (answersString != null && answersString.isNotEmpty) {
        answers = _parseAnswers(answersString);
      }

      if (answers.isEmpty) {
        print("Không có câu trả lời nào cho exam_id: $examId");
        continue; 
      }
      syncedAnswers.add({
        'id': log['id'],
        'user_id': userId,
        'answers': answers,
      });
    }

    return syncedAnswers;
  } catch (e) {
    print("Lỗi khi lấy danh sách câu trả lời đã đồng bộ: $e");
    return [];
  }
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
      where: 'exam_id = ?',
      whereArgs: [examId],
    );

    if (result.isNotEmpty) {
      final file = result.first['file_data'];
      return file != null;
    }

    return false;
  }

}
