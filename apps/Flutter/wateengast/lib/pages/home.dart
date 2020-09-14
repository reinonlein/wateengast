import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:badges/badges.dart';
import 'dart:async';
import 'dart:convert';
import 'package:wateengast/models/singlepost.dart';
import 'package:wateengast/models/singlecategory.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<SinglePost> parsePosts(response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
  return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
}

List<SingleCategory> parseCategories(responseCat) {
  final parsedCat = jsonDecode(responseCat).cast<Map<String, dynamic>>();
  return parsedCat.map<SingleCategory>((json) => SingleCategory.fromJson(json)).toList();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = new ScrollController();
  int page = 1;
  List currentPostList = [];
  List currentCategoryList = [];

  Future<List<SinglePost>> _getPosts() async {
    var queryParameters = {
      '_embed': '',
      'per_page': '30',
      'page': page.toString(),
      'categories': '',
    };

    var uri = Uri.https('www.wateengast.nl', '/wp-json/wp/v2/posts', queryParameters);

    final response = await http.get(uri);
    return compute(parsePosts, response.body);
  }

  Future<List<SingleCategory>> _getCategories() async {
    final responseCat =
        await http.get('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=50');
    return compute(parseCategories, responseCat.body);
  }

  @override
  void initState() {
    super.initState();
    analytics.setCurrentScreen(screenName: '/home');
    _getPosts().then((response) {
      currentPostList = response;
      setState(() {});
    });
    _getCategories().then((responseCat) {
      currentCategoryList = responseCat;
      setState(() {});
    });

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
                    Text(' ',
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
            }),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: currentCategoryList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return DrawerHeader(
                child: Center(
                  child: Text(
                    'Alle categorieën op \n Wat een gast!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              );
            }
            return ListTile(
              title: Text(currentCategoryList[index - 1].name),
              trailing: SizedBox(
                width: 28.0,
                height: 28.0,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: Text(
                    currentCategoryList[index - 1].count,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  elevation: 1.5,
                ),
              ),
              // trailing: CircleAvatar(
              //   radius: 14,
              //   backgroundColor: Colors.green,
              //   child: Text(
              //     currentCategoryList[index - 1].count,
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                print(currentCategoryList[index].id);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}

// drawer: Drawer(
//   child: ListView(
//     // Important: Remove any padding from the ListView.
//     padding: EdgeInsets.zero,
//     children: <Widget>[
//       DrawerHeader(
//         child: Text('Alle categoriën'),
//         decoration: BoxDecoration(
//           color: Colors.green,
//         ),
//       ),
//       ListTile(
//         title: Text('Auto en verkeer'),
//         trailing: FloatingActionButton(
//           onPressed: null,
//           mini: true,
//           elevation: 0,
//           child: Text('42'),
//         ),
//         onTap: () {
//           // Update the state of the app
//           // ...
//           // Then close the drawer
//           Navigator.pop(context);
//         },
//       ),
//       ListTile(
//         title: Text('Hobby en vrije tijd'),
//         trailing: FloatingActionButton(
//           onPressed: null,
//           mini: true,
//           elevation: 0,
//           child: Text('14'),
//         ),
//         onTap: () {
//           // Update the state of the app
//           // ...
//           // Then close the drawer
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   ),
// ),
