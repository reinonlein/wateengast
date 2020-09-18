import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Map post = {};

  @override
  Widget build(BuildContext context) {
    post = ModalRoute.of(context).settings.arguments;

    print(post);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wat een gast...',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: FadeInImage.assetNetwork(
              placeholder: 'images/loading.gif',
              fit: BoxFit.cover,
              image: post['image'],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 23.0, 15.0, 5.0),
            child: Text(post['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
            child: Html(
              defaultTextStyle: TextStyle(fontSize: 14.5),
              data: post['content'],
              padding: EdgeInsets.all(10.0),
              onLinkTap: (url) async {
                if (await canLaunch(url)) {
                  await launch(url, forceWebView: false);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Terug naar alle posts'),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
