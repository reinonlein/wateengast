import 'package:flutter/material.dart';
import 'package:wateengast/pages/postdetail.dart';
import 'package:wateengast/pages/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

//import 'package:google_fonts/google_fonts.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  runApp(
    MaterialApp(
      title: 'Wat een gast!',
      theme: ThemeData(
        accentColor: Colors.green,
        appBarTheme: AppBarTheme(color: Colors.green), //#4CAF50 RGB 76 175 80
        primarySwatch: Colors.green,
        fontFamily: 'Nunito',
        //textTheme: GoogleFonts.notoSansTextTheme(), //nunitoSans, workSans montserrat,
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

///lato
///none
///roboto
///raleway
///open sans
///
///
///
