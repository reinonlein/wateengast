import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wateengast/models/singlecategory.dart';
import 'package:wateengast/models/singlepost.dart';

List<SinglePost> parsePosts(response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
  return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
}

List<SingleCategory> parseCategories(responseCat) {
  final parsedCat = jsonDecode(responseCat).cast<Map<String, dynamic>>();
  return parsedCat.map<SingleCategory>((json) => SingleCategory.fromJson(json)).toList();
}

class WordpressAPI {
  int page = 1;
  int perPage = 100;
  String category = '';

  Future<List<SinglePost>> getPosts(String afterDate) async {
    var queryParameters = {
      '_embed': '',
      'per_page': perPage.toString(),
      'page': page.toString(),
      //'categories': category,
      'after': afterDate.toString(),
    };

    var uri = Uri.https('www.wateengast.nl', '/wp-json/wp/v2/posts', queryParameters);
    print(uri);
    final response = await http.get(uri);
    return compute(parsePosts, response.body);
  }

  Future<List<SingleCategory>> getCategories() async {
    final responseCat =
        await http.get('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=50&exclude=1');
    return compute(parseCategories, responseCat.body);
  }
}
