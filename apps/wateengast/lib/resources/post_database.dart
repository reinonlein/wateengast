import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import '../models/singlepost.dart';

class PostDatabase {
  Database db;

  init() async {
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "post_database.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Posts
            (
              id INTEGER PRIMARY KEY,
              title TEXT,
              date TEXT,
              content TEXT,
              slug TEXT,
              image TEXT,
              thumbnail TEXT,
              categories TEXT,
              modified TEXT
            )
        ''');
      },
    );
  }

  fetchPost(int id) async {
    final maps = await db.query(
      "Posts",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {}

    return null;
  }

  fetchAll() async {
    final maps = await db.query(
      "Posts",
      columns: null,
    );
  }
}
