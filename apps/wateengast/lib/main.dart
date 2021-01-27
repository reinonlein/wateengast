// import 'package:flutter/material.dart';
// import 'package:wateengast/car_demo/main_page.dart';

// void main() {
//   runApp(App());
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Car Database'),
//         ),
//         body: MainPage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wateengast/pages/postdetail.dart';
import 'package:wateengast/pages/home.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:wateengast/services/sharedpreferences.dart';

//import 'package:google_fonts/google_fonts.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();

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
