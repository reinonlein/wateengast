import 'dart:convert';

import 'package:alcoholvrijheid/models/singlecategory.dart';
import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/screens/blog/blogpostlist.dart';
import 'package:alcoholvrijheid/screens/home/alcoholvrijheid_card.dart';
import 'package:alcoholvrijheid/screens/home/home_drawer.dart';
import 'package:alcoholvrijheid/screens/home/settings_page.dart';
import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/services/database.dart';

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
        return;
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
            'content': currentPostList[0].content,
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _pages = <Widget>[
      AlcoholvrijheidCards(), //this is a stateful widget on a separate file
      BlogPostlist(blogPostlist: currentPostList),
      SettingsPage(),
    ];

    return StreamProvider<List<Alcoholvrijerd>>.value(
      value: DatabaseService().alcoholvrijerds,
      child: Scaffold(
        drawer: HomeDrawer(),
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
              label: 'Alle verhalen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Mijn stopgegevens',
            )
          ],
        ),
        appBar: AppBar(
          title: Text(
            'Alcoholvrijheid',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 1.0,
                  color: Color.fromARGB(150, 0, 0, 0),
                ),
              ],
            ),
          ),
          centerTitle: true,
          iconTheme: new IconThemeData(color: Colors.white),
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
      ),
    );
  }
}
