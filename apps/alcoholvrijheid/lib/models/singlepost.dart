import 'package:html_unescape/html_unescape.dart';

var unescape = new HtmlUnescape();

class SinglePost {
  final String title, date, content, category, link, image, thumbnail;

  SinglePost({
    this.title,
    this.date,
    this.content,
    this.category,
    this.link,
    this.image,
    this.thumbnail,
  });

  factory SinglePost.fromJson(Map<String, dynamic> json) {
    return SinglePost(
      title: unescape.convert(json['title']['rendered']),
      date: json['date'],
      content: json['content']['rendered'],
      category: json['_embedded']['wp:term'][0][0]['name'] ?? 'Ongecategoriseerd',
      link: json['link'],
      image: json['_embedded']['wp:featuredmedia'][0]['source_url'] ?? '',
      thumbnail: json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['thumbnail']
              ['source_url'] ??
          '',
    );
  }
}
