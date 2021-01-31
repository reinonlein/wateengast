import 'dart:convert';
import 'dart:math';

import 'package:html_unescape/html_unescape.dart';

var unescape = new HtmlUnescape();

class SinglePost {
  final int id;
  final String title, date, content, slug, image, thumbnail, category1, categories, modified;

  SinglePost({
    this.id,
    this.title,
    this.date,
    this.content,
    this.slug,
    this.image,
    this.thumbnail,
    this.category1,
    this.categories,
    this.modified,
  });

  factory SinglePost.fromJson(Map<String, dynamic> json) {
    return SinglePost(
      id: json['id'],
      title: unescape.convert(json['title']['rendered']),
      date: json['date'],
      content: json['content']['rendered'],
      slug: json['slug'],
      image: json['_embedded']['wp:featuredmedia'][0]['source_url'] ?? '',
      thumbnail: json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']
              ['source_url'] ??
          '',
      category1: json['_embedded']['wp:term'][0][0]['name'] ?? '[1]',
      categories: json['categories'].toString() ?? 'leeg',
      modified: json['modified'],
    );
  }

  // image:
  //         'https://www.wateengast.nl/wp-content/uploads/2021/01/aardappelboor-150x150.jpg', //json['_embedded']['wp:featuredmedia'][0]['source_url'] ?? '',
  //     thumbnail:
  //         'https://www.wateengast.nl/wp-content/uploads/2021/01/aardappelboor-150x150.jpg', //json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']['source_url'] ?? '',

  factory SinglePost.fromDb(Map<String, dynamic> db) {
    return SinglePost(
      id: db['id'],
      title: db['title'],
      date: db['date'],
      content: db['content'],
      slug: db['slug'],
      image: db['image'],
      thumbnail: db['thumbnail'],
      category1: db['category1'],
      categories: db['categories'],
      modified: db['modified'],
    );
  }

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date,
      'content': content,
      'slug': slug,
      'image': image,
      'thumbnail': thumbnail,
      'category1': category1,
      'categories': categories,
      'modified': modified,
    };
  }

  factory SinglePost.fromBackupJson(Map<String, dynamic> json) {
    return SinglePost(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      content: json['content'],
      slug: json['slug'],
      image: json['image'],
      thumbnail: json['thumbnail'],
      category1: json['category1'],
      categories: json['categories'],
      modified: json['modified'],
    );
  }

  static Map<String, dynamic> toMapForBackupJson(SinglePost post) => {
        'id': post.id,
        'title': post.title,
        'date': post.date,
        'content': post.content,
        'slug': post.slug,
        'image': post.image,
        'thumbnail': post.thumbnail,
        'category1': post.category1,
        'categories': post.categories,
        'modified': post.modified,
      };

  static String encode(List<SinglePost> posts) => json.encode(
        posts.map<Map<String, dynamic>>((post) => SinglePost.toMapForBackupJson(post)).toList(),
      );

  static List<SinglePost> decode(String post) => (json.decode(post) as List<dynamic>)
      .map<SinglePost>((item) => SinglePost.fromBackupJson(item))
      .toList();
}
