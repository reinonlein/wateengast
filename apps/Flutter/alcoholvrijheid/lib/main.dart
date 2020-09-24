import 'package:flutter/material.dart';
import 'package:alcoholvrijheid/pages/postdetail.dart';
import 'package:alcoholvrijheid/pages/home.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';
//import 'package:google_fonts/google_fonts.dart';

//FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  runApp(
    MaterialApp(
      title: 'Alcoholvrijheid',
      theme: ThemeData(
        accentColor: Colors.amber,
        appBarTheme: AppBarTheme(color: Colors.amber),
        primarySwatch: Colors.amber,
        fontFamily: 'Nunito',
        // textTheme:
        //     GoogleFonts.nunitoTextTheme(), //nunitoSans, notoSansTextTheme workSans montserrat,
      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/postdetail': (context) => PostDetail(),
      },
    ),
  );
}
