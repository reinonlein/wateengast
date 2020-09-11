import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:wateengast/models/singlepost.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<SinglePost> parsePosts(response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
  return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
}

class _HomeState extends State<Home> {
  Future<List> futurePostList;
  ScrollController _scrollController = new ScrollController();
  int page = 1;
  List currentPostList = [];

  Future<List<SinglePost>> _getPosts() async {
    var queryParameters = {
      '_embed': '',
      'per_page': '30',
      'page': page.toString(),
    };

    var uri = Uri.https('www.wateengast.nl', '/wp-json/wp/v2/posts', queryParameters);

    final response = await http.get(uri);
    return compute(parsePosts, response.body);
  }

  @override
  void initState() {
    super.initState();
    futurePostList = _getPosts();
    _getPosts().then((response) {
      currentPostList = response;
      setState(() {});
    });
    //loading = false;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // if we are at the bottom of the page
        page += 1;
        FirebaseAnalytics().logEvent(
          name: 'infinite_scrolled',
          parameters: {'target_page': page},
        );
        _getPosts().then((response) {
          currentPostList.addAll(response);
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wat een gast...'),
        backgroundColor: Colors.green, //#4CAF50 RGB 76 175 80
        centerTitle: true,
      ),
      body: Center(
          child: ListView.separated(
              controller: _scrollController,
              itemCount: currentPostList.length + 1,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                if (currentPostList.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200),
                      Text('Wat een gast!',
                          style: TextStyle(
                            fontSize: 24,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SpinKitThreeBounce(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                } else if (index == currentPostList.length) {
                  return new ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    title: Text('Een momentje!'),
                    subtitle: Text('Er worden meer posts opgehaald...'),
                  );
                } else {
                  return new ListTile(
                      title: Text(currentPostList[index].title),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loadingbox.gif',
                          image: currentPostList[index].thumbnail,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
                      onTap: () {
                        FirebaseAnalytics().logEvent(
                          name: 'read_post',
                          parameters: {'Title': currentPostList[index].title},
                        );
                        Navigator.pushNamed(
                          context,
                          '/postdetail',
                          arguments: {
                            'title': currentPostList[index].title,
                            'image': currentPostList[index].image,
                            'content': currentPostList[index].content,
                          },
                        );
                      });
                }
              })),
    );
  }
}
