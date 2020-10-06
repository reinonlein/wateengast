import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:alcoholvrijheid/shared/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  DateTime _currentStopdate;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              margin: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Wijzig hier je stopgegevens',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20.0),
                        Column(children: <Widget>[
                          Text('Wanneer heb je voor het laatst gedronken?'),
                          DateTimeField(
                            resetIcon: null,
                            format: DateFormat("d MMMM yyyy, HH:mm"),
                            initialValue: userData.stopdate,
                            decoration: textInputDecoration,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  helpText: "KIES JE STOPDATUM",
                                  firstDate: DateTime(2000),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime.now());
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(currentValue),
                                );
                                return _currentStopdate = DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                        ]),
                        SizedBox(height: 20.0),
                        // dropdown
                        DropdownButtonFormField(
                          decoration: textInputDecoration,
                          value: _currentSugars ?? userData.sugars,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _currentSugars = val),
                        ),
                        // slider
                        Slider(
                          value: (_currentStrength ?? userData.strength).toDouble(),
                          activeColor: Colors.brown[_currentStrength ?? userData.strength],
                          inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                          min: 100,
                          max: 900,
                          divisions: 8,
                          onChanged: (val) => setState(() => _currentStrength = val.round()),
                        ),
                        // button
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print(_currentStopdate);
                              print(userData.stopdate);
                              await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name,
                                _currentStopdate ?? userData.stopdate,
                                _currentSugars ?? userData.sugars,
                                _currentStrength ?? userData.strength,
                              );
                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Je wijzigingen zijn opgeslagen!',
                                  textAlign: TextAlign.center,
                                ),
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
