import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  late Database _database;

  static final _instance = DBProvider._internal();
  DBProvider._internal();

  factory DBProvider() => _instance;

  Future<void> initDB() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,'app_db.sql');

    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {
      },
      onCreate: (Database db , int version) async {
        db.execute('CREATE TABLE notes('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'content TEXT'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion){},
      onDowngrade: (Database db, int oldVersion, int newVersion){}
    );
  }

  Database get database => _database;

}