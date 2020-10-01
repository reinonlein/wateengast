import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alcoholvrijheid/models/brew.dart';
import 'package:alcoholvrijheid/screens/home/settings_form.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Alcoholvrijheid!'),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text(''),
              onPressed: (() async {
                await _auth.signOut();
              }),
            ),
            FlatButton.icon(
              onPressed: (() => _showSettingsPanel()),
              icon: Icon(Icons.settings),
              label: Text(''),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rainbow-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
