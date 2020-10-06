import 'package:alcoholvrijheid/screens/home/alcoholvrijheid_card.dart';
import 'package:alcoholvrijheid/screens/home/home_drawer.dart';
import 'package:alcoholvrijheid/screens/home/postlist_temp.dart';
import 'package:alcoholvrijheid/screens/home/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  var _pages = <Widget>[
    AlcoholvrijheidCards(), //this is a stateful widget on a separate file
    Blog(), //this is a stateful widget on a separate file
    SettingsPage(), //this is a stateful widget on a separate file
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text(
            'Mijn Alcoholvrijheid!',
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
