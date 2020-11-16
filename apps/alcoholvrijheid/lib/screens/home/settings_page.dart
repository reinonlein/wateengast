import 'package:alcoholvrijheid/services/notificationscheduler.dart';
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

  // form values
  String _currentName;
  DateTime _currentStopdate;
  int _currentGeld;
  int _currentBier;
  int _currentWijn;
  int _currentSterk;
  int _currentKaters;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wijzig je stopgegevens'),
        centerTitle: true,
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              return Container(
                margin: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
                child: ListView(
                  children: [
                    Form(
                      // TODO: validator voor negatieve getallen of tekst
                      // TODO: voorloopnullen fixen
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                              'Op deze pagina kun je jouw stopgegevens aanpassen. Vergeet niet om onderaan op \'Opslaan\' te drukken om je wijzigingen op te slaan als je klaar bent.\n'),
                          Text(
                            'Wat is je naam?',
                            style: formTextStyle,
                          ),
                          TextFormField(
                            initialValue: userData.name,
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                            onChanged: (val) => setState(() => _currentName = val),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: <Widget>[
                              Text(
                                'Wanneer heb je voor het laatst gedronken?',
                                style: formTextStyle,
                              ),
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
                                      initialTime: TimeOfDay(hour: 0, minute: 0),
                                      //initialTime: TimeOfDay.fromDateTime(currentValue),
                                    );
                                    return _currentStopdate = DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Hoeveel euro gaf je gemiddeld per week uit aan alcohol?',
                                style: formTextStyle,
                              ),
                              TextFormField(
                                initialValue: userData.geld.toString(),
                                decoration: textInputDecoration,
                                validator: (val) => val.isEmpty ? 'Vul aub een bedrag in' : null,
                                onChanged: (val) => setState(() => _currentGeld = int.parse(val)),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Hoeveel biertjes dronk je gemiddeld per week?',
                                style: formTextStyle,
                              ),
                              TextFormField(
                                initialValue: userData.bier.toString(),
                                decoration: textInputDecoration,
                                validator: (val) =>
                                    val.isEmpty ? 'Vul aub een aantal biertjes in' : null,
                                onChanged: (val) => setState(() => _currentBier = int.parse(val)),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Hoeveel wijntjes dronk je gemiddeld per week?',
                                style: formTextStyle,
                              ),
                              TextFormField(
                                initialValue: userData.wijn.toString(),
                                decoration: textInputDecoration,
                                validator: (val) =>
                                    val.isEmpty ? 'Vul aub een aantal wijntjes in' : null,
                                onChanged: (val) => setState(() => _currentWijn = int.parse(val)),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Hoeveel glazen sterke drank dronk je gemiddeld per week?',
                                style: formTextStyle,
                              ),
                              TextFormField(
                                initialValue: userData.sterk.toString(),
                                decoration: textInputDecoration,
                                validator: (val) =>
                                    val.isEmpty ? 'Vul aub een aantal sterke drankjes in' : null,
                                onChanged: (val) => setState(() => _currentSterk = int.parse(val)),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Hoe vaak had je gemiddeld per maand een kater?',
                                style: formTextStyle,
                              ),
                              TextFormField(
                                initialValue: userData.katers.toString(),
                                decoration: textInputDecoration,
                                validator: (val) =>
                                    val.isEmpty ? 'Vul aub een aantal katers in' : null,
                                onChanged: (val) => setState(() => _currentKaters = int.parse(val)),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          // button
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Opslaan',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserSettings(
                                  _currentName ?? userData.name,
                                  _currentStopdate ?? userData.stopdate,
                                  _currentGeld ?? userData.geld,
                                  _currentBier ?? userData.bier,
                                  _currentWijn ?? userData.wijn,
                                  _currentSterk ?? userData.sterk,
                                  _currentKaters ?? userData.katers,
                                  DateTime.now(),
                                )
                                    .then((_) {
                                  notificationScheduler(
                                    _currentStopdate ?? userData.stopdate,
                                    _currentBier ?? userData.bier,
                                    _currentWijn ?? userData.wijn,
                                    _currentSterk ?? userData.sterk,
                                    _currentGeld ?? userData.geld,
                                    _currentKaters ?? userData.katers,
                                  );
                                  setState(() {});
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Je wijzigingen zijn opgeslagen!',
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Oeps, je hebt een veld niet goed ingevuld',
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
          }),
    );
  }
}
