// GAK JADI MAKE SQFLITE RIBET WKWK


// import 'dart:io';

// import 'package:bmi_app/database/db_schema.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseInstance {
//   Database? _database;
//   final String _databaseName = 'bmi_alarm.db';
//   final int _databaseVersion = 2;
//   final String _table = 'alarm';

//   Future database() async {
//     if (_database != null) {
//       return _database;
//     } else {
//       _database = await _initialDatabase();
//       return _database;
//     }
//   }

//   Future _initialDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String documentPath = directory.path;

//     // DB
//     String databasePath = join(documentPath, _databaseName);

//     return openDatabase(
//       databasePath,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''CREATE TABLE $_table (
//       $id INTEGER  PRIMARY KEY,
//       $title TEXT NULL,
//       $colorIndex INTEGER NULL,
//       $time TEXT NULL,
//       $isActive TEXT NULL,
//       $isRepeat TEXT NULL)
// ''');
//   }

//   // UPGRADE DATABASE TABLES
//   void _onUpgrade(Database db, int oldVersion, int newVersion) {
//     if (oldVersion < newVersion) {
//       db.execute("ALTER TABLE $_table ADD COLUMN newCol TEXT;");
//     }
//   }

//   Future<List<Alarm>> getAll() async {
//     final query = await _database?.query(_table) ?? [];

//     List<Alarm> listAlarm = query.map((e) => Alarm.fromMap(e)).toList();

//     print(listAlarm.length);
//     return listAlarm;
//   }

//   Future<int> insertData({required Map<String, dynamic> data}) async {
//     final query = await _database?.insert(_table, data) ?? 0;
//     return query;
//   }

//   Future<int> updateData(
//       {required Map<String, dynamic> data, required int alarmID}) async {
//     final query = await _database
//         ?.update(_table, data, where: '$id = ?', whereArgs: [alarmID]);
//     return query ?? 0;
//   }

//   Future<int> deleteData({int? alarmID}) async {
//     final query = await _database?.delete(_table);

//     print(query);
//     return query ?? 0;
//   }
// }
