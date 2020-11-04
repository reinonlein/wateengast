import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List reminders = ['het is duur', 'het is kut', 'het is naar'];

class Reminders extends StatefulWidget {
  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  FocusNode myFocusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text('Mijn reminders'),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 2,
              child: Icon(Icons.add),
              onPressed: () {
                myFocusNode.requestFocus();
              },
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Door welke nadelen van alcohol wilde je ook alweer stoppen met drinken?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextField(
                    controller: _controller,
                    autofocus: false,
                    autocorrect: false,
                    focusNode: myFocusNode,
                    onSubmitted: (val) {
                      setState(() {
                        if (val != '') {
                          reminders.add(val.trim());
                          _controller.clear();
                        }
                      }); // Close the add todo screen
                    },
                    decoration: InputDecoration(
                        hintText: 'Een nadeel van alcohol is...',
                        contentPadding: const EdgeInsets.all(16.0)),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: reminders.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(reminders[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.clear_rounded,
                                      size: 19,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        reminders.removeAt(index);
                                      });
                                    }),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
