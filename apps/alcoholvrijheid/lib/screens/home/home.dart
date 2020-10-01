import 'package:alcoholvrijheid/screens/home/alcoholvrijerds_list.dart';
import 'package:alcoholvrijheid/screens/home/alcoholvrijerds_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/screens/home/settings_form.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/services/auth.dart';

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

    return StreamProvider<List<Alcoholvrijerd>>.value(
      value: DatabaseService().alcoholvrijerds,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: Text('Alcoholvrijheid!'),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('logout'),
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
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/rainbow-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: AlcoholvrijerdCards(),
        ),
      ),
    );
  }
}
