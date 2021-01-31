import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wateengast/models/singlepost.dart';
import 'package:wateengast/resources/wordpress_api.dart';

// DIT IS DE CODE OM EEN JSON EXPORT VAN DE WORDPRESS API IN TE LEZEN

// Future<List<SinglePost>> getMemory2018() async {
//     final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2018.json');
//     return compute(parsePosts, response);
//   }

//   Future<List<SinglePost>> getMemory2019() async {
//     final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2019.json');
//     return compute(parsePosts, response);
//   }

//   Future<List<SinglePost>> getMemory2020() async {
//     final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2020.json');
//     return compute(parsePosts, response);
//   }

//   Future<void> firstTimePopulateDb() async {
//     getMemory2018().then((response) {
//       for (var item in response) {
//         db.addPost(item);
//       }
//       print('2018 ingeladen');
//       getMemory2019().then((response) {
//         for (var item in response) {
//           db.addPost(item);
//         }
//         print('2019 ingeladen');
//         getMemory2020().then((response) {
//           for (var item in response) {
//             db.addPost(item);
//           }
//           print('2020 ingeladen');
//           setupPostList();
//         });
//       });
//       print('De database is voor het eerst gevuld.');
//     });
//   }

//   void setupPostList() async {
//     var _posts = await db.fetchAll();
//     print('Post length = ${_posts.length}');
//     if (_posts.length == 0) {
//       firstTimePopulateDb();
//     }
//     setState(() {
//       postlist = _posts;
//     });
//   }

// // posts opslaan als bestand
// _exportPosts(postList) async {
//   final downloadDirectory = await DownloadsPathProvider.downloadsDirectory;
//   final file2 = File('${downloadDirectory.path}/posts.txt');
//   final String encodedData = SinglePost.encode(postList);
//   await file2.writeAsString(encodedData);
//   print('saved');
// }

// // om ze weer op te halen en te converteren naar posts
// _readPosthistory() async {
//   try {
//     //final directory = await getApplicationDocumentsDirectory();
//     //final file = File('assets/posthistory.txt');
//     //String encodedData = await file.readAsString();
//     String encodedData =
//         await DefaultAssetBundle.of(context).loadString('assets/posthistory.txt');
//     List<SinglePost> newPostlist = SinglePost.decode(encodedData);
//     return newPostlist;
//   } catch (e) {
//     String returnstring = "empty";
//     print(e);
//     return returnstring;
//   }
// }
