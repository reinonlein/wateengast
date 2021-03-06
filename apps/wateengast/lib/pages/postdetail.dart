import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/style.dart';
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
                        fontFamily: 'Montserrat',
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
            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 15.0),
            child: Html(
              defaultTextStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                height: 1.8,
                //letterSpacing: -0.1,
                fontWeight: FontWeight.w500,
              ),
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

// child: Html(
//               defaultTextStyle: TextStyle(
//                 fontSize: 15,
//                 height: 1.8,
//                 letterSpacing: -0.1,
//                 fontWeight: FontWeight.w500,
//               ),
//               data: post['content'],
//               padding: EdgeInsets.all(10.0),
//               onLinkTap: (url) async {
//                 if (await canLaunch(url)) {
//                   await launch(url, forceWebView: false);
//                 } else {
//                   throw 'Could not launch $url';
//                 }
//               },
//             ),

//Nieuw:
// child: Html(
//   data: post['content'],
//   style: {
//     "html": Style(
//       padding: EdgeInsets.all(10),
//       fontSize: FontSize(15),
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.2,
//       //textAlign: TextAlign.justify,
//     ),
//   },
//   onLinkTap: (url) async {
//     if (await canLaunch(url)) {
//       await launch(url, forceWebView: false);
//     } else {
//       throw 'Could not launch $url';
//     }
//   },
// ),
