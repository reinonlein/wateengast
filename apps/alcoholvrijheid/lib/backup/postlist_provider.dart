import 'package:http/http.dart' as http;
import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/backup/homeblog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostlistProvider extends ChangeNotifier {
  int page = 1;
  int perPage = 100;
  int postCount = 1000;
  List currentPostList = [];

  List<SinglePost> _test = [];

  List<SinglePost> get test {
    return [..._test];
  }

  Future<List<SinglePost>> getPosts() async {
    var queryParameters = {
      '_embed': '',
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    var uri = Uri.https('www.alcoholvrijheid.nl', '/wp-json/wp/v2/posts', queryParameters);
    print(uri);
    final response = await http.get(uri);
    compute(parsePosts, response.body).then((result) {
      currentPostList = result;
      _test = result;
      print(currentPostList);
      notifyListeners();
      return _test;
    });
  }
}
