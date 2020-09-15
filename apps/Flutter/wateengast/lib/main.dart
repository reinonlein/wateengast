import 'package:flutter/material.dart';
import 'package:wateengast/pages/postdetail.dart';
import 'package:wateengast/pages/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  runApp(
    MaterialApp(
      title: 'Wat een gast!',
      theme: ThemeData(
        accentColor: Colors.green,
        appBarTheme: AppBarTheme(color: Colors.green),
        primarySwatch: Colors.green,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/postdetail': (context) => PostDetail(),
      },
    ),
  );
}
