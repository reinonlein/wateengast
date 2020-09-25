import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/models/singlecategory.dart';

//FirebaseAnalytics analytics = FirebaseAnalytics();

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
  int perPage = 100;
  int postCount = 1000;
  int availablePages = 40;
  List currentPostList = [];
  List currentCategoryList = [];
  String category = '';
  String categoryName = 'Alcoholvrijheid';

  Future<List<SinglePost>> _getPosts() async {
    var queryParameters = {
      '_embed': '',
      'per_page': perPage.toString(),
      'page': page.toString(),
      'categories': category,
    };

    var uri = Uri.https('www.alcoholvrijheid.nl', '/wp-json/wp/v2/posts', queryParameters);
    print(uri);
    final response = await http.get(uri);
    return compute(parsePosts, response.body);
  }

  Future<List<SingleCategory>> _getCategories() async {
    final responseCat = await http.get('https://www.alcoholvrijheid.nl/wp-json/wp/v2/categories');
    return compute(parseCategories, responseCat.body);
  }

  @override
  void initState() {
    super.initState();

//    final fbm = FirebaseMessaging();

//    fbm.subscribeToTopic('AlcoholvrijheidTopic');
    //fbm.subscribeToTopic('TestingTopic');

    _getPosts().then((response) {
      currentPostList = response;

      //   fbm.configure(
      //     onMessage: (message) {
      //       print(message);
      //       return showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           // return object of type Dialog
      //           return AlertDialog(
      //             title: new Text(
      //               "Goed nieuws!",
      //               style: TextStyle(
      //                 color: Colors.amber,
      //               ),
      //             ),
      //             content: new Text("Er staat een nieuwe post live. Wil je die nu gelijk lezen?"),
      //             actions: <Widget>[
      //               // usually buttons at the bottom of the dialog
      //               Row(
      //                 children: [
      //                   new FlatButton(
      //                     child: new Text("Jazekers!"),
      //                     onPressed: () {
      //                       Navigator.popAndPushNamed(
      //                         context,
      //                         '/postdetail',
      //                         arguments: {
      //                           'title': currentPostList[0].title,
      //                           'image': currentPostList[0].image,
      //                           'content': currentPostList[0].content,
      //                         },
      //                       );
      //                     },
      //                   ),
      //                   new FlatButton(
      //                     child: new Text("Nee dank je"),
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     },
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           );
      //         },
      //       );
      //     },
      //     onLaunch: (message) {
      //       print(message);
      //       return Navigator.pushNamed(
      //         context,
      //         '/postdetail',
      //         arguments: {
      //           'title': currentPostList[0].title,
      //           'image': currentPostList[0].image,
      //           'content': currentPostList[0].content,
      //         },
      //       );
      //     },
      //     onResume: (message) {
      //       print(message);
      //       setState(() {
      //         category = '';
      //         currentPostList = [];
      //         postCount = 1000;
      //         availablePages = 40;
      //         page = 1;
      //       });
      //       _getPosts().then((response) {
      //         currentPostList.addAll(response);
      //         setState(() {});
      //       });
      //       return Navigator.pushNamed(
      //         context,
      //         '/postdetail',
      //         arguments: {
      //           'title': currentPostList[0].title,
      //           'image': currentPostList[0].image,
      //           'content': currentPostList[0].content,
      //         },
      //       );
      //     },
      //   );
      setState(() {});
    });
    _getCategories().then((responseCat) {
      currentCategoryList = responseCat;
      setState(() {});
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // if we are at the bottom of the page
        page + 1 > availablePages ? page = availablePages : page += 1;
        //page + 1 > availablePages ? perPage = postCount % perPage : perPage = perPage;
        print(postCount);
        print(currentPostList.length);
        // FirebaseAnalytics().logEvent(
        //   name: 'infinite_scrolled',
        //   parameters: {'target_page': page},
        // );
        if (currentPostList.length != postCount) {
          _getPosts().then((response) {
            currentPostList.addAll(response);
            setState(() {});
          });
        } else {
          print('End of list!');
        }
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
        title: Text(
          categoryName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.amber,
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
                    if (categoryName != 'Alcoholvrijheid')
                      Text(categoryName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          )),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SpinKitThreeBounce(
                        color: Colors.amber,
                      ),
                    ),
                  ],
                );
              } else if (index == postCount) {
                return new ListTile();
              } else if (index == currentPostList.length) {
                print(index);
                print(currentPostList.length);
                print(postCount);
                return new ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  title: Text(
                    'Een momentje!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      height: 1.3,
                    ),
                  ),
                  subtitle: Text('Er worden meer posts opgehaald...'),
                );
              } else {
                return new ListTile(
                    title: Text(
                      currentPostList[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        height: 1.3,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Hero(
                        tag: 'hero-${currentPostList[index].title}',
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loadingbox.gif',
                          image: currentPostList[index].thumbnail,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
                    onTap: () {
                      // FirebaseAnalytics().logEvent(
                      //   name: 'read_post',
                      //   parameters: {'Title': currentPostList[index].title},
                      // );
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
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            Container(
              height: 160,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'Welkom in de Alcoholvrijheid-app!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Alle categorieën',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                currentPostList = [];
                setState(() {});
                page = 1;
                category = '';
                categoryName = 'Alle verhalen';
                _getPosts().then((response) {
                  currentPostList = response;
                  page = 1;
                  setState(() {});
                });
                Navigator.pop(context);
              },
            ),
            Container(
              height: double.maxFinite,
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: currentCategoryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(currentCategoryList[index].name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                    trailing: SizedBox(
                      width: 28.0,
                      height: 28.0,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Text(
                          currentCategoryList[index].count,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        elevation: 1.5,
                      ),
                    ),
                    onTap: () {
                      // FirebaseAnalytics().logEvent(
                      //   name: 'category_selected',
                      //   parameters: {'category': categoryName},
                      // );
                      // Update the state of the app
                      category = currentCategoryList[index].id;
                      setState(() {
                        currentPostList = [];
                        categoryName = currentCategoryList[index].name;
                        postCount = int.parse(currentCategoryList[index].count);
                        availablePages =
                            (int.parse(currentCategoryList[index].count) / perPage).ceil();
                        print(availablePages);
                      });
                      page = 1;
                      _getPosts().then((response) {
                        currentPostList.addAll(response);
                        setState(() {});
                      });
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
