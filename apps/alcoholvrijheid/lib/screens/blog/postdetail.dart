import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
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
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Alcoholvrijheid',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Hero(
                  tag: 'hero-${post['title']}',
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/loading.gif',
                    fit: BoxFit.cover,
                    image: post['image'],
                  ),
                ),
              ),
              Positioned(
                bottom: 17,
                left: 20,
                right: 20,
                child: Container(
                  //padding: const EdgeInsets.fromLTRB(17.0, 23.0, 17.0, 5.0),
                  child: Text(post['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 8.0,
                            color: Color.fromARGB(200, 0, 0, 0),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            child: Html(
              data: post['content'],
              style: {
                "html": Style(
                  padding: EdgeInsets.all(10),
                  fontSize: FontSize(16),
                  //fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  //textAlign: TextAlign.justify,
                ),
              },
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
