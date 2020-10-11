import 'dart:convert';

import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/screens/blog/homeblog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostListProvider extends ChangeNotifier {
  int page = 1;
  int perPage = 25;
  int postCount = 1000;
  int availablePages = 40;
  Future<List<SinglePost>> futurePostList;
  final List<SinglePost> _providerPostList = [];

  List<SinglePost> parsePosts(response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
  }

  Future<List<SinglePost>> getFuturePosts() async {
    var queryParameters = {
      '_embed': '',
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    var uri = Uri.https('www.alcoholvrijheid.nl', '/wp-json/wp/v2/posts', queryParameters);
    print(uri);
    final response = await http.get(uri);
    futurePostList = compute(parsePosts, response.body);
    notifyListeners();
    return futurePostList;
  }
}
