import 'package:html_unescape/html_unescape.dart';

var unescape = new HtmlUnescape();

class SinglePost {
  final String title, date, content, image, thumbnail;

  SinglePost({
    this.title,
    this.date,
    this.content,
    this.image,
    this.thumbnail,
  });

  factory SinglePost.fromJson(Map<String, dynamic> json) {
    return SinglePost(
      title: unescape.convert(json['title']['rendered']),
      content: json['content']['rendered'],
      date: json['date'],
      image: json['_embedded']['wp:featuredmedia'][0]['source_url'],
      thumbnail: json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']
          ['source_url'],
    );
  }
}
