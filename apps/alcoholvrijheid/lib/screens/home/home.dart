import 'dart:convert';

import 'package:alcoholvrijheid/backup/av_members_tile.dart';
import 'package:alcoholvrijheid/models/singlecategory.dart';
import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/screens/authenticate/authenticate.dart';
import 'package:alcoholvrijheid/screens/authenticate/register.dart';
import 'package:alcoholvrijheid/screens/authenticate/stopgegevens_message.dart';
import 'package:alcoholvrijheid/screens/blog/blogpostlist.dart';
import 'package:alcoholvrijheid/screens/home/av_cards.dart';
import 'package:alcoholvrijheid/screens/home/home_drawer.dart';
import 'package:alcoholvrijheid/screens/home/settings_page.dart';
import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/backup/postlist_provider.dart';
import 'package:alcoholvrijheid/shared/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
  int _selectedIndex = 0;

  int page = 1;
  int perPage = 100;
  int postCount = 1000;
  int availablePages = 40;
  List currentPostList = [];
  List currentCategoryList = [];
  String filterCategory = 'Alcoholvrijheid';
  String category = '';
  String categoryName = 'Wat een gast...';

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
    final responseCat =
        await http.get('https://www.alcoholvrijheid.nl/wp-json/wp/v2/categories?per_page=50');
    return compute(parseCategories, responseCat.body);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _getPosts().then((response) {
      currentPostList = response;
      setState(() {});
    });

    _getCategories().then((responseCat) {
      currentCategoryList = responseCat;
      setState(() {});
    });

    final fbm = FirebaseMessaging();

    //fbm.subscribeToTopic('WordpressTopic');
    //fbm.subscribeToTopic('TestingTopic');

    fbm.configure(
      onMessage: (message) {
        print(message);
        _selectedIndex = 1;
        return Navigator.pushNamed(
          context,
          '/postdetail',
          arguments: {
            'title': currentPostList[0].title,
            'image': currentPostList[0].image,
            'link': currentPostList[0].link,
            'category': currentPostList[0].category,
            'content': currentPostList[0].content,
          },
        );
      },
      onLaunch: (message) {
        print(message);
        _selectedIndex = 1;
        setState(() {
          category = 'Alcoholvrijheid';
          currentPostList = [];
        });
        _getPosts().then((response) {
          currentPostList.addAll(response);
          setState(() {});
        });
        return Navigator.pushNamed(
          context,
          '/postdetail',
          arguments: {
            'title': currentPostList[0].title,
            'image': currentPostList[0].image,
            'link': currentPostList[0].link,
            'category': currentPostList[0].category,
            'content': currentPostList[0].content,
          },
        );
      },
      onResume: (message) {
        print(message);
        _selectedIndex = 1;
        setState(() {
          category = 'Alcoholvrijheid';
          currentPostList = [];
        });
        _getPosts().then((response) {
          currentPostList.addAll(response);
          setState(() {});
        });
        return Navigator.pushNamed(
          context,
          '/postdetail',
          arguments: {
            'title': currentPostList[0].title,
            'image': currentPostList[0].image,
            'link': currentPostList[0].link,
            'category': currentPostList[0].category,
            'content': currentPostList[0].content,
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);

    var _pages = <Widget>[
      user == null
          ? Authenticate()
          : AlcoholvrijheidCards(), //this is a stateful widget on a separate file
      BlogPostlist(
          blogPostlist: filterCategory == 'Alcoholvrijheid'
              ? currentPostList
              : currentPostList.where((i) => i.category == filterCategory).toList()),
      user == null ? StopgegevensMessage() : SettingsPage(),
    ];

    // code snippet om een lijst van alle leden te krijgen
    // return StreamProvider<List<Alcoholvrijerd>>.value(
    //   value: DatabaseService().alcoholvrijerds,

    return ChangeNotifierProvider(
      create: (context) => PostlistProvider(),
      child: Scaffold(
        //drawer: HomeDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex, // this will be set when a new tab is tapped
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.alarm),
              label: 'Alcoholvrijheid',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.web),
              label: filterCategory == 'Alcoholvrijheid'
                  ? 'Alle verhalen'
                  : filterCategory, //'Alle verhalen' //
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Mijn stopgegevens',
            )
          ],
        ),
        appBar: user == null && _selectedIndex == 0
            ? null
            : AppBar(
                title: _selectedIndex == 1
                    ? Text(filterCategory)
                    : Text(
                        'Alcoholvrijheid',
                        // style: TextStyle(
                        //   color: Colors.white,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 20,
                        //   shadows: <Shadow>[
                        //     Shadow(
                        //       offset: Offset(0.0, 0.0),
                        //       blurRadius: 1.0,
                        //       color: Color.fromARGB(150, 0, 0, 0),
                        //     ),
                        //   ],
                        // ),
                      ),
                centerTitle: true,
                //iconTheme: new IconThemeData(color: Colors.white),
                backgroundColor: Colors.amber,
                elevation: 2.0,
              ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
              image: AssetImage('assets/rainbow-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: _pages.elementAt(_selectedIndex),
        ),
        drawer: user == null
            ? null
            : Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: [
                    Container(
                      height: 160,
                      child: DrawerHeader(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Alcoholvrijheid',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Haal de rem van je leven.',
                                style: TextStyle(
                                  fontSize: 17,
                                  //color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Alle verhalen',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Alle verhalen'},
                              );
                              setState(() {
                                filterCategory = 'Alcoholvrijheid';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Ervaringsverhalen',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Ervaringsverhalen'},
                              );
                              setState(() {
                                filterCategory = 'Ervaringsverhalen';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Voordelen van stoppen',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Voordelen van stoppen'},
                              );
                              setState(() {
                                filterCategory = 'Voordelen';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Alternatieve drankjes',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Alternatieve drankjes'},
                              );
                              setState(() {
                                filterCategory = 'Alternatieven';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Vragen en stellingen',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Vragen en stellingen'},
                              );
                              setState(() {
                                filterCategory = 'Vragen';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Tips en advies',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Tips en advies'},
                              );
                              setState(() {
                                filterCategory = 'Tips';
                                _selectedIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Over Alcoholvrijheid',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Over alcoholvrijheid'},
                              );
                              Navigator.popAndPushNamed(context, '/over_alcoholvrijheid');
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Over deze app',
                              style: drawerItemStyle,
                            ),
                            onTap: () {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Over deze app'},
                              );
                              Navigator.popAndPushNamed(context, '/over_deze_app');
                              //Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text(
                              'Logout',
                              style: drawerItemStyle,
                            ),
                            onTap: (() async {
                              FirebaseAnalytics().logEvent(
                                name: 'drawer_navigation',
                                parameters: {'target': 'Logout'},
                              );
                              await _auth.signOut();
                              Navigator.pop(context);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
