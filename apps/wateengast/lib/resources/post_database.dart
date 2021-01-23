import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
// import 'dart:io';
// import 'dart:async';
import '../models/singlepost.dart';

// List<SinglePost> parsePosts(response) {
//   final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
//   return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
// }

// Future<List<SinglePost>> getPosts() async {
//     final response = await http.get('www.wateengast.nl/wp-json/wp/v2/posts');
//     return compute(parsePosts, response.body);
//   }

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
              category1 TEXT,
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

    if (maps.length > 0) {
      return SinglePost.fromDatabase(maps.first);
    }

    return null;
  }

  addPost(SinglePost post) {
    return db.insert("Posts", post.toMapForDatabase());
  }
}

// from https://github.com/PharosProduction/tutorial-flutter-sqflite/tree/master/lib/src/database

// Future<List<Car>> fetchAll() async {
//     var client = await db;
//     var res = await client.query('car');

//     if (res.isNotEmpty) {
//       var cars = res.map((carMap) => Car.fromDb(carMap)).toList();
//       return cars;
//     }
//     return [];
//   }
