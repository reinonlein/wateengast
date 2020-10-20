import 'package:alcoholvrijheid/screens/blog/postdetail.dart';
import 'package:alcoholvrijheid/screens/home/home.dart';
import 'package:alcoholvrijheid/screens/home/settings_page.dart';
import 'package:alcoholvrijheid/screens/info/over_alcoholvrijheid.dart';
import 'package:alcoholvrijheid/screens/info/over_deze_app.dart';
import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          '/home': (context) => Home(),
          '/settings': (context) => SettingsPage(),
          '/over_deze_app': (context) => OverDezeApp(),
          '/over_alcoholvrijheid': (context) => OverAlcoholvrijheid(),
          '/postdetail': (context) => PostDetail(),
        },
      ),
    );
  }
}
