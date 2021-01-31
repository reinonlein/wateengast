import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:wateengast/models/singlecategory.dart';
import 'package:wateengast/models/singlepost.dart';
import 'package:wateengast/resources/post_database.dart';
import 'package:wateengast/resources/wordpress_api.dart';
import 'package:wateengast/services/sharedpreferences.dart';

import 'package:downloads_path_provider/downloads_path_provider.dart';

// TODO allereerste keer laden spinner toevoegen
// TODO json dump van alle posts tot nu toe maken en inladen
// TODO nieuwe posts markeren
// TODO wordpress posts ophalen vanaf datum modified

FirebaseAnalytics analytics = FirebaseAnalytics();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<SingleCategory> parseCategories(responseCat) {
  final parsedCat = jsonDecode(responseCat).cast<Map<String, dynamic>>();
  return parsedCat.map<SingleCategory>((json) => SingleCategory.fromJson(json)).toList();
}

class _HomeState extends State<Home> {
  final db = PostDatabase();
  List<SinglePost> postlist = [];
  String afterDate = sharedPrefs.afterDate;

  Future<void> getWordpressApiPosts() async {
    WordpressAPI().getPosts(afterDate).then((response) {
      for (var item in response) {
        db.addPost(item);
      }
      setupPostList();
      print('Wordpress posts opgehaald');

      sharedPrefs.previousDate = afterDate;
      sharedPrefs.afterDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()).toString();
      afterDate = DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()).toString();
      return;
    });
  }

  Future<List<SinglePost>> getMemory2018() async {
    final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2018.json');
    return compute(parsePosts, response);
  }

  Future<List<SinglePost>> getMemory2019() async {
    final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2019.json');
    return compute(parsePosts, response);
  }

  Future<List<SinglePost>> getMemory2020() async {
    final response = await DefaultAssetBundle.of(context).loadString('assets/posthistory2020.json');
    return compute(parsePosts, response);
  }

  // posts opslaan als bestand
  _exportPosts(postList) async {
    final downloadDirectory = await DownloadsPathProvider.downloadsDirectory;
    final file2 = File('${downloadDirectory.path}/posts.txt');
    final String encodedData = SinglePost.encode(postList);
    await file2.writeAsString(encodedData);
    print('saved');
  }

  // om ze weer op te halen en te converteren naar posts
  _readPosthistory() async {
    try {
      //final directory = await getApplicationDocumentsDirectory();
      //final file = File('assets/posthistory.txt');
      //String encodedData = await file.readAsString();
      String encodedData =
          await DefaultAssetBundle.of(context).loadString('assets/posthistory.json');
      List<SinglePost> newPostlist = SinglePost.decode(encodedData);
      return newPostlist;
    } catch (e) {
      String returnstring = "empty";
      print(e);
      return returnstring;
    }
  }

  // Future<void> firstTimePopulateDb() async {
  //   getMemory2018().then((response) {
  //     for (var item in response) {
  //       db.addPost(item);
  //     }
  //     print('2018 ingeladen');
  //     getMemory2019().then((response) {
  //       for (var item in response) {
  //         db.addPost(item);
  //       }
  //       print('2019 ingeladen');
  //       getMemory2020().then((response) {
  //         for (var item in response) {
  //           db.addPost(item);
  //         }
  //         print('2020 ingeladen');
  //         setupPostList();
  //       });
  //     });
  //     print('De database is voor het eerst gevuld.');
  //   });
  // }

  Future<void> firstTimePopulateDb() async {
    _readPosthistory().then((response) {
      for (var item in response) {
        db.addPost(item);
      }
      print('Posthistory ingeladen');
      //setupPostList();
      print('De database is voor het eerst gevuld.');
    }).then((_) {
      getWordpressApiPosts();
    });
  }

  void setupPostList() async {
    var _posts = await db.fetchAll();
    print('Post length = ${_posts.length}');
    if (_posts.length == 0) {
      firstTimePopulateDb();
    }
    setState(() {
      postlist = _posts;
      postlist.sort((a, b) => b.date.compareTo(a.date));
      //_exportPosts(postlist);
    });
  }

  ScrollController _scrollController = new ScrollController();
  int page = 1;
  int perPage = 25;
  int postCount = 1000;
  int availablePages = 40;
  List currentPostList = [];
  List currentCategoryList = [];
  String category = '';
  String categoryName = 'Wat een gast...';

  final postDatabase = PostDatabase();
  List<SinglePost> databasePosts = [];

  @override
  void initState() {
    super.initState();
    setupPostList();

    if (postlist.length > 0) {
      getWordpressApiPosts();
    }

    // db.getData().then((value){
    //   _valueState = value;
    // });

    final fbm = FirebaseMessaging();

    fbm.subscribeToTopic('WordpressTopic');
    //fbm.subscribeToTopic('TestingTopic');

    analytics.setCurrentScreen(screenName: '/home');

    WordpressAPI().getPosts(afterDate).then((response) {
      currentPostList = response;

      fbm.configure(
        onMessage: (message) {
          print(message);
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text(
                  "Goed nieuws!",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                content: new Text("Er staat een nieuwe vraag live. Wil je die nu gelijk lezen?"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  Row(
                    children: [
                      new FlatButton(
                        child: new Text("Jazekers!"),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                            context,
                            '/postdetail',
                            arguments: {
                              'title': currentPostList[0].title,
                              'image': currentPostList[0].image,
                              'content': currentPostList[0].content,
                            },
                          );
                        },
                      ),
                      new FlatButton(
                        child: new Text("Nee dank je"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        onLaunch: (message) {
          print(message);
          return Navigator.pushNamed(
            context,
            '/postdetail',
            arguments: {
              'title': currentPostList[0].title,
              'image': currentPostList[0].image,
              'content': currentPostList[0].content,
            },
          );
        },
        onResume: (message) {
          print(message);
          setState(() {
            category = '';
            currentPostList = [];
            postCount = 1000;
            availablePages = 40;
            page = 1;
          });
          WordpressAPI().getPosts(afterDate).then((response) {
            currentPostList.addAll(response);
            setState(() {});
          });
          return Navigator.pushNamed(
            context,
            '/postdetail',
            arguments: {
              'title': currentPostList[0].title,
              'image': currentPostList[0].image,
              'content': currentPostList[0].content,
            },
          );
        },
      );
      setState(() {});
    });
    WordpressAPI().getCategories().then((responseCat) {
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
        FirebaseAnalytics().logEvent(
          name: 'infinite_scrolled',
          parameters: {'target_page': page},
        );
        if (currentPostList.length != postCount) {
          WordpressAPI().getPosts(afterDate).then((response) {
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
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: getWordpressApiPosts,
          // child: ListView.separated(
          //     controller: _scrollController,
          //     itemCount: postlist.length, //currentPostList.length + 1,
          //     separatorBuilder: (BuildContext context, int index) => Divider(),
          //     padding: EdgeInsets.all(10),
          //     itemBuilder: (context, index) {
          //       if (postlist.length == 0) {
          //         return Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SizedBox(height: 200),
          //             if (categoryName != 'Wat een gast...')
          //               Text(categoryName,
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.w400,
          //                   )),
          //             Padding(
          //               padding: const EdgeInsets.all(15.0),
          //               child: SpinKitThreeBounce(
          //                 color: Colors.green,
          //               ),
          //             ),
          //           ],
          //         );
          //       } else if (index == postCount) {
          //         return new ListTile();
          //         // } else if (index == postlist.length) {
          //         //   print(index);
          //         //   print(postlist.length);
          //         //   print(postCount);
          //         //   return new ListTile(
          //         //     leading: Padding(
          //         //       padding: const EdgeInsets.all(8.0),
          //         //       child: CircularProgressIndicator(),
          //         //     ),
          //         //     title: Text(
          //         //       'Een momentje!',
          //         //       style: TextStyle(
          //         //         fontSize: 15,
          //         //         fontWeight: FontWeight.w500,
          //         //         letterSpacing: 0,
          //         //         height: 1.3,
          //         //       ),
          //         //     ),
          //         //     subtitle: Text('Er worden meer posts opgehaald...'),
          //         //   );
          //       } else {
          //         return new ListTile(
          //             title: Text(
          //               postlist[index].title,
          //               style: TextStyle(
          //                 fontSize: 15.5,
          //                 fontWeight: FontWeight.w500,
          //                 letterSpacing: 0,
          //                 height: 1.3,
          //               ),
          //             ),
          //             leading: ClipRRect(
          //               borderRadius: BorderRadius.circular(6.0),
          //               child: Hero(
          //                 tag: 'hero-${postlist[index].title}',
          //                 child: FadeInImage.assetNetwork(
          //                   placeholder: 'assets/loadingbox.gif',
          //                   image: postlist[index].thumbnail,
          //                 ),
          //               ),
          //             ),
          //             contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
          //             onTap: () {
          //               FirebaseAnalytics().logEvent(
          //                 name: 'read_post',
          //                 parameters: {'Title': postlist[index].title},
          //               );
          //               print(postlist[index].category1);
          //               print(json.decode(postlist[index].categories));
          //               print(postlist[index].id);
          //               //print(json.decode(currentPostList[index].categories).contains(1));
          //               Navigator.pushNamed(
          //                 context,
          //                 '/postdetail',
          //                 arguments: {
          //                   'title': postlist[index].title,
          //                   'image': postlist[index].image,
          //                   'content': postlist[index].content,
          //                 },
          //               );
          //             });
          //       }
          //     }),
          child: postlist.length == 0
              ? Center(child: SpinKitThreeBounce(color: Colors.green))
              : ListView.separated(
                  padding: EdgeInsets.all(10),
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemCount: postlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                          postlist[index].title,
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            height: 1.3,
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Hero(
                            tag: 'hero-${postlist[index].title}',
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loadingbox.gif',
                              image: postlist[index].thumbnail,
                            ),
                          ),
                        ),
                        trailing: DateTime.parse(postlist[index].date)
                                .isAfter(DateTime.parse(sharedPrefs.previousDate))
                            ? Text('Nieuw!',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ))
                            : null,
                        contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
                        onTap: () {
                          FirebaseAnalytics().logEvent(
                            name: 'read_post',
                            parameters: {'Title': postlist[index].title},
                          );
                          print(postlist[index].category1);
                          print(json.decode(postlist[index].categories));
                          print(postlist[index].id);
                          //print(json.decode(currentPostList[index].categories).contains(1));
                          Navigator.pushNamed(
                            context,
                            '/postdetail',
                            arguments: {
                              'title': postlist[index].title,
                              'image': postlist[index].image,
                              'content': postlist[index].content,
                            },
                          );
                        });
                  },
                )),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 160,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'Alle categorieën op \n Wat een gast!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            ListTile(
              //leading: Icon(Icons.question_answer),
              trailing: SizedBox(
                width: 21.0,
                height: 23.0,
                child: FaIcon(
                  FontAwesomeIcons.question,
                  size: 21.0,
                  color: Colors.green,
                ),
              ),
              title: Text(
                'Stel een vraag op Wateengast.nl!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                FirebaseAnalytics().logEvent(
                  name: 'drawer_navigation',
                  parameters: {'target': 'Stel een vraag'},
                );
                if (await canLaunch('https://www.wateengast.nl/stel-een-vraag')) {
                  await launch('https://www.wateengast.nl/stel-een-vraag');
                } else {
                  throw 'Could not launch url';
                }
              },
            ),
            ListTile(
              trailing: SizedBox(
                width: 24.0,
                height: 24.0,
                child: FaIcon(
                  FontAwesomeIcons.listUl,
                  size: 21.0,
                  color: Colors.green,
                ),
              ),
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
                categoryName = 'Alle vragen';
                WordpressAPI().getPosts(afterDate).then((response) {
                  currentPostList = response;
                  page = 1;
                  setState(() {});
                });
                Navigator.pop(context);
              },
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(top: 5),
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
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            elevation: 1.5,
                          ),
                        ),
                        onTap: () {
                          FirebaseAnalytics().logEvent(
                            name: 'category_selected',
                            parameters: {'category': categoryName},
                          );
                          print(currentCategoryList[index].name);
                          print(currentCategoryList[index].id);
                          // // Update the state of the app
                          // category = currentCategoryList[index].id;
                          // setState(() {
                          //   currentPostList = [];
                          //   categoryName = currentCategoryList[index].name;
                          //   postCount = int.parse(currentCategoryList[index].count);
                          //   availablePages =
                          //       (int.parse(currentCategoryList[index].count) / perPage).ceil();
                          //   print(availablePages);
                          // });
                          // page = 1;
                          // _getPosts().then((response) {
                          //   currentPostList.addAll(response);
                          //   setState(() {});
                          // });
                          // // Then close the drawer
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
                // ListView.builder(
                //   padding: const EdgeInsets.all(0.0),
                //   itemCount: currentCategoryList.length + 2,
                //   itemBuilder: (context, index) {
                //     if (index == 0) {
                //       return Container(
                //         height: 160,
                //         child: DrawerHeader(
                //           child: Center(
                //             child: Text(
                //               'Alle categorieën op \n Wat een gast!',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 fontFamily: 'Montserrat',
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 21,
                //               ),
                //             ),
                //           ),
                //           decoration: BoxDecoration(
                //             color: Colors.green,
                //           ),
                //         ),
                //       );
                //     } else if (index == 1) {
                //       return ListTile(
                //         //leading: Icon(Icons.question_answer),
                //         trailing: SizedBox(
                //           width: 21.0,
                //           height: 23.0,
                //           child: FaIcon(
                //             FontAwesomeIcons.question,
                //             size: 21.0,
                //             color: Colors.green,
                //           ),
                //         ),
                //         title: Text(
                //           'Stel een vraag op Wateengast.nl!',
                //           style: TextStyle(
                //             fontSize: 15,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         onTap: () async {
                //           FirebaseAnalytics().logEvent(
                //             name: 'drawer_navigation',
                //             parameters: {'target': 'Stel een vraag'},
                //           );
                //           if (await canLaunch('https://www.wateengast.nl/stel-een-vraag')) {
                //             await launch('https://www.wateengast.nl/stel-een-vraag');
                //           } else {
                //             throw 'Could not launch url';
                //           }
                //         },
                //       );
                //     } else if (index == 2) {
                //       return Divider();
                //     } else if (index == 3) {
                //       return ListTile(
                //         trailing: SizedBox(
                //           width: 24.0,
                //           height: 24.0,
                //           child: FaIcon(
                //             FontAwesomeIcons.listUl,
                //             size: 21.0,
                //             color: Colors.green,
                //           ),
                //         ),
                //         title: Text(
                //           'Alle categorieën',
                //           style: TextStyle(
                //             fontSize: 15,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         onTap: () {
                //           currentPostList = [];
                //           setState(() {});
                //           page = 1;
                //           category = '';
                //           categoryName = 'Alle vragen';
                //           _getPosts().then((response) {
                //             currentPostList = response;
                //             page = 1;
                //             setState(() {});
                //           });
                //           Navigator.pop(context);
                //         },
                //       );
                //     } else {
                //       return ListTile(
                //         title: Text(currentCategoryList[index - 4].name,
                //             style: TextStyle(
                //               fontSize: 15,
                //               fontWeight: FontWeight.w500,
                //             )),
                //         trailing: SizedBox(
                //           width: 28.0,
                //           height: 28.0,
                //           child: FloatingActionButton(
                //             onPressed: () {},
                //             child: Text(
                //               currentCategoryList[index - 4].count,
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 11,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             elevation: 1.5,
                //           ),
                //         ),
                //         onTap: () {
                //           FirebaseAnalytics().logEvent(
                //             name: 'category_selected',
                //             parameters: {'category': categoryName},
                //           );
                //           // Update the state of the app
                //           category = currentCategoryList[index - 4].id;
                //           setState(() {
                //             currentPostList = [];
                //             categoryName = currentCategoryList[index - 4].name;
                //             postCount = int.parse(currentCategoryList[index - 4].count);
                //             availablePages =
                //                 (int.parse(currentCategoryList[index - 4].count) / perPage).ceil();
                //             print(availablePages);
                //           });
                //           page = 1;
                //           _getPosts().then((response) {
                //             currentPostList.addAll(response);
                //             setState(() {});
                //           });
                //           // Then close the drawer
                //           Navigator.pop(context);
                //         },
                //       );
                //     }
                //   },
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
