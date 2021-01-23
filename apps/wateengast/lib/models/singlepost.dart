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
      category1: json['_embedded']['wp:term'][0][0]['name'] ?? 'leeg',
      categories: json['categories'].toString(),
      modified: json['modified'],
    );
  }

  factory SinglePost.fromDatabase(Map<String, dynamic> db) {
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

  Map<String, dynamic> toMapForDatabase() {
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
}
