import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                ListTile(
                  title: Text(
                    'Alle verhalen',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Voordelen van stoppen',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context, 'Voordelen');
                  },
                ),
                ListTile(
                  title: Text(
                    'Ervaringsverhalen',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Alternatieven',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Over Alcoholvrijheid',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Over deze app',
                    style: drawerItemStyle,
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/over_deze_app');
                    //Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Logout',
                    style: drawerItemStyle,
                  ),
                  onTap: (() async {
                    await _auth.signOut();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
