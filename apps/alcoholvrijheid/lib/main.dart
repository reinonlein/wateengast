import 'package:alcoholvrijheid/screens/blog/postdetail.dart';
import 'package:alcoholvrijheid/screens/home/home.dart';
import 'package:alcoholvrijheid/screens/home/prestaties.dart';
import 'package:alcoholvrijheid/screens/home/reminders.dart';
import 'package:alcoholvrijheid/screens/home/settings_page.dart';
import 'package:alcoholvrijheid/screens/info/changelog.dart';
import 'package:alcoholvrijheid/screens/info/over_alcoholvrijheid.dart';
import 'package:alcoholvrijheid/screens/info/over_deze_app.dart';
import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/notificationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:rxdart/rxdart.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.amber,
          appBarTheme: AppBarTheme(color: Colors.amber),
          primarySwatch: Colors.amber,
          fontFamily: 'Nunito',
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/settings': (context) => SettingsPage(),
          '/over_deze_app': (context) => OverDezeApp(),
          '/over_alcoholvrijheid': (context) => OverAlcoholvrijheid(),
          '/changelog': (context) => Changelog(),
          '/postdetail': (context) => PostDetail(),
          '/prestaties': (context) => Prestaties(),
          '/reminders': (context) => Reminders(),
          '/stopgegevens': (context) => SettingsPage(),
        },
      ),
    );
  }
}
