import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wateengast/models/singlepost.dart';

class PostDatabase {
  static final PostDatabase _instance = PostDatabase._();
  static Database _database;

  PostDatabase._();

  factory PostDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'postlistdatabase.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database newDb, int version) {
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
              category1 TEXT,
              categories TEXT,
              modified TEXT
            )
        ''');
    print("PostDatabase created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addPost(SinglePost post) async {
    var client = await db;
    return client.insert('Posts', post.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SinglePost> fetchPost(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('Posts', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return SinglePost.fromDb(maps.first);
    }

    return null;
  }

  Future<List<SinglePost>> fetchAll() async {
    var client = await db;
    var res = await client.query('Posts');

    if (res.isNotEmpty) {
      var postlist = res.map((postMap) => SinglePost.fromDb(postMap)).toList();
      return postlist.reversed.toList();
    }
    return [];
  }

  Future<int> updatePost(SinglePost newPost) async {
    var client = await db;
    return client.update('Posts', newPost.toMapForDb(),
        where: 'id = ?', whereArgs: [newPost.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removePost(int id) async {
    var client = await db;
    return client.delete('Posts', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/singlepost.dart';

// class PostDatabase {
//   Database db;

//   init() async {
//     var databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, "post_database.db");
//     db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database newDb, int version) {
//         newDb.execute('''
//           CREATE TABLE Posts
//             (
//               id INTEGER PRIMARY KEY,
//               title TEXT,
//               date TEXT,
//               content TEXT,
//               slug TEXT,
//               image TEXT,
//               thumbnail TEXT,
//               category1 TEXT,
//               categories TEXT,
//               modified TEXT
//             )
//         ''');
//         print("PostDatabase created!");
//       },
//     );
//   }

//   fetchPost(int id) async {
//     final maps = await db.query(
//       "Posts",
//       columns: null,
//       where: "id = ?",
//       whereArgs: [id],
//     );

//     if (maps.length > 0) {
//       return SinglePost.fromDb(maps.first);
//     }

//     return null;
//   }

//   addPost(SinglePost post) {
//     return db.insert("Posts", post.toMapForDb());
//   }
// }
