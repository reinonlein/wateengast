import 'dart:convert';

import 'package:alcoholvrijheid/main.dart';
import 'package:alcoholvrijheid/models/prestatietargets.dart';
import 'package:alcoholvrijheid/models/singlecategory.dart';
import 'package:alcoholvrijheid/models/singlepost.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/screens/authenticate/authenticate.dart';
import 'package:alcoholvrijheid/screens/authenticate/stopgegevens_message.dart';
import 'package:alcoholvrijheid/screens/blog/blogpostlist.dart';
import 'package:alcoholvrijheid/screens/home/av_cards.dart';
import 'package:alcoholvrijheid/screens/home/prestaties.dart';
import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/services/notificationService.dart';
import 'package:alcoholvrijheid/shared/constants.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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
  bool _newVisit = false;

  bool notifications = true;

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

  // Future<List<SingleCategory>> _getCategories() async {
  //   final responseCat =
  //       await http.get('https://www.alcoholvrijheid.nl/wp-json/wp/v2/categories?per_page=50');
  //   return compute(parseCategories, responseCat.body);
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body) : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Home(),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) {
      List<Map> prestaties = PrestatieTargets().prestatietargets;
      int index = int.parse(payload);
      AwesomeDialog(
        context: context,
        customHeader: ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: Image.asset('assets/trophygif.gif'),
        ),
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        title: prestaties[index]['title'],
        desc: prestaties[index]['content'],
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
        btnOkText: 'Geweldig!',
        btnOkIcon: Icons.thumb_up_sharp,
        headerAnimationLoop: false,
        isDense: false,
        btnOkOnPress: () {},
      )..show();
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _configureLocalTimeZone();
    _configureSelectNotificationSubject();
    _configureDidReceiveLocalNotificationSubject();

    _newVisit = true;

    _getPosts().then((response) {
      currentPostList = response;
      setState(() {});
    });

    // _getCategories().then((responseCat) {
    //   currentCategoryList = responseCat;
    //   setState(() {});
    // });

    final fbm = FirebaseMessaging();

    fbm.subscribeToTopic('FirebaseMessaging');
    fbm.subscribeToTopic('FirebaseTest');

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
    Jiffy.locale("nl");

    if (user != null && _newVisit == true) {
      DatabaseService(uid: user.uid).updateUserLastSeenTime(DateTime.now());
      _newVisit = false;
    }

    var _pages = <Widget>[
      user == null
          ? Authenticate()
          : AlcoholvrijheidCards(), //this is a stateful widget on a separate file
      BlogPostlist(
          blogPostlist: filterCategory == 'Alcoholvrijheid'
              ? currentPostList
              : currentPostList.where((i) => i.category == filterCategory).toList()),
      user == null ? StopgegevensMessage() : Prestaties(),
    ];

    List<Map> prestaties = PrestatieTargets().prestatietargets;

    // code snippet om een lijst van alle leden te krijgen
    // return StreamProvider<List<Alcoholvrijerd>>.value(
    //   value: DatabaseService().alcoholvrijerds,

    return Scaffold(
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
            icon: Icon(Icons.emoji_events_outlined),
            label: 'Mijn prestaties',
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
      body: RefreshIndicator(
        onRefresh: () => _getPosts().then((response) {
          if (user != null) {
            DatabaseService(uid: user.uid).updateUserLastSeenTime(DateTime.now());
          }
          currentPostList = response;
          setState(() {});
        }),
        child: Container(
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
                        RaisedButton(
                          child: Text('test notificatie'),
                          onPressed: () async {
                            await showNotification(flutterLocalNotificationsPlugin);
                          },
                        ),
                        RaisedButton(
                          child: Text('schedule notificatie'),
                          onPressed: () async {
                            await scheduleNotification(
                                flutterLocalNotificationsPlugin,
                                3,
                                'Gefeliciteerd: ${prestaties[3]['title']}!',
                                prestaties[3]['content'].substring(0, 100),
                                tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)));
                          },
                        ),
                        StreamBuilder<UserData>(
                            stream: DatabaseService(uid: user.uid).userData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                UserData userData = snapshot.data;
                                int stopuren = Jiffy().diff(userData.stopdate, Units.HOUR);
                                double stopmaanden =
                                    Jiffy().diff(userData.stopdate, Units.MONTH, true);
                                int liters = ((stopuren / (7 * 24)) * userData.bier * 0.3).round() +
                                    ((stopuren / (7 * 24)) * userData.wijn * 0.125).round() +
                                    ((stopuren / (7 * 24)) * userData.sterk * 0.035).round();
                                int katers = (stopmaanden * userData.katers).floor();
                                return RaisedButton(
                                    child: Text('schedule uren prestaties'),
                                    onPressed: () async {
                                      //for (index in range 0 tot prestaties.length)
                                      for (var i = 0; i < prestaties.length; i++) {
                                        if (prestaties[i]['eenheid'] == 'uren' &&
                                            tz.TZDateTime.from(userData.stopdate, tz.local)
                                                .add(Duration(hours: prestaties[i]['target']))
                                                .isAfter(tz.TZDateTime.now(tz.local))) {
                                          await scheduleNotification(
                                              flutterLocalNotificationsPlugin,
                                              i,
                                              'Gefeliciteerd: ${prestaties[i]['title']}!',
                                              prestaties[i]['content'].substring(0, 100),
                                              tz.TZDateTime.from(userData.stopdate, tz.local)
                                                  .add(Duration(hours: prestaties[i]['target'])));
                                        } else if (prestaties[i]['eenheid'] == 'maanden') {
                                          await scheduleNotification(
                                              flutterLocalNotificationsPlugin,
                                              i,
                                              'Gefeliciteerd: ${prestaties[i]['title']}!',
                                              prestaties[i]['content'].length < 100
                                                  ? prestaties[i]['content']
                                                  : prestaties[i]['content'].substring(0, 100),
                                              tz.TZDateTime.now(tz.local).add(
                                                  Duration(days: prestaties[i]['target'] * 31)));
                                        } else if (prestaties[i]['eenheid'] == 'katers') {
                                          await scheduleNotification(
                                              flutterLocalNotificationsPlugin,
                                              i,
                                              'een katers notificatie!',
                                              prestaties[i]['content'].length < 100
                                                  ? prestaties[i]['content']
                                                  : prestaties[i]['content'].substring(0, 100),
                                              tz.TZDateTime.now(tz.local).add(
                                                  Duration(days: prestaties[i]['target'] * 31)));
                                        }
                                      }
                                    });
                              } else {
                                return RaisedButton(
                                    child: Text('dan maar deze'),
                                    onPressed: () async {
                                      await checkPendingNotificationRequests(
                                          flutterLocalNotificationsPlugin, this.context);
                                    });
                              }
                            }),
                        RaisedButton(
                          child: Text('overzicht'),
                          onPressed: () async {
                            await checkPendingNotificationRequests(
                                flutterLocalNotificationsPlugin, this.context);
                          },
                        ),
                        RaisedButton(
                          child: Text('uitzetten'),
                          onPressed: () async {
                            await turnOffNotification(flutterLocalNotificationsPlugin);
                          },
                        ),
                        ListTile(
                          //leading: Icon(Icons.info_outline_rounded),
                          title: Text(
                            'Wat is Alcoholvrijheid?',
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
                        SizedBox(
                          child: Divider(),
                        ),
                        ListTile(
                          leading: Icon(Icons.emoji_events_outlined),
                          title: Text(
                            'Mijn prestaties',
                            style: drawerItemStyle,
                          ),
                          onTap: () {
                            FirebaseAnalytics().logEvent(
                              name: 'drawer_navigation',
                              parameters: {'target': 'Prestaties'},
                            );
                            setState(() {
                              _selectedIndex = 2;
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.bubble_chart_outlined),
                          title: Text(
                            'Mijn alcoholreminders',
                            style: drawerItemStyle,
                          ),
                          onTap: () {
                            FirebaseAnalytics().logEvent(
                              name: 'drawer_navigation',
                              parameters: {'target': 'Reminders'},
                            );
                            Navigator.popAndPushNamed(context, '/reminders');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person_rounded),
                          title: Text(
                            'Mijn stopgegevens',
                            style: drawerItemStyle,
                          ),
                          onTap: () {
                            FirebaseAnalytics().logEvent(
                              name: 'drawer_navigation',
                              parameters: {'target': 'Stopgegevens'},
                            );
                            Navigator.popAndPushNamed(context, '/stopgegevens');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.smartphone),
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
                        SwitchListTile(
                          secondary: Icon(Icons.notifications_on_outlined),
                          title: Text('Ontvang felicitaties'),
                          value: notifications,
                          onChanged: (bool value) {
                            setState(() {
                              notifications = value;
                              print(notifications);
                            });
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
    );
  }
}
