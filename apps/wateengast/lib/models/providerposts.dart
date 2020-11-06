import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wateengast/models/singlepost.dart';
import 'package:http/http.dart' as http;

class ProviderPosts extends ChangeNotifier {
  int page = 1;
  int perPage = 25;
  int postCount = 1000;
  int availablePages = 40;
  List currentPostList = [];
  List testList = ['A', 'B', 'C'];
  final List _items = ['test', 'list'];

  /// An unmodifiable view of the items in the cart.
  List get items => _items;

  void add(item) {
    _items.add(item);
    notifyListeners();
  }

  //List get getCurrentPostList => currentPostList;

  List get getCurrentPostList {
    return currentPostList;
  }

  List get getTestList {
    return testList;
  }

  Future<List<SinglePost>> getPosts() async {
    List<SinglePost> parsePosts(response) {
      final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
      return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
    }

    var queryParameters = {
      '_embed': '',
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    var uri = Uri.https('www.wateengast.nl', '/wp-json/wp/v2/posts', queryParameters);
    print(uri);
    final response = await http.get(uri);
    return compute(parsePosts, response.body);
  }
}
