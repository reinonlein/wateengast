import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/constants.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  DateTime stopdate = DateTime.now();
  int geld = 0;
  int bier = 0;
  int wijn = 0;
  int sterk = 0;
  int katers = 0;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.amber[500],
              //elevation: 0.0,
              title: Text(
                'Om te beginnen...',
                style: TextStyle(fontSize: 17),
              ),
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Inloggen'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Icon(Icons.emoji_events_outlined),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 20.0),
                      child: Text(
                        'Welkom bij Alcoholvrijheid!',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'En gefeliciteerd! Deze app gaat je namelijk helpen om eindelijk eens écht alcoholvrij door het leven te gaan. Niet omdat het moet, maar juist omdat je dat zelf wilt! De mooie ervaringsverhalen, tips en statistiekjes geven je net dat duwtje in de rug naar een heerlijk alcoholvrij leven.\n\nAls je gestopt bent met drinken, kan je hieronder je stopgegevens invullen om je voortgang bij te houden, of klik hierboven op inloggen als je dit al een keer eerder hebt gedaan.\n\nVeel plezier en inspiratie toegewenst!',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Wat is je naam?',
                        alignLabelWithHint: true,
                        hintText: 'Naam',
                        suffixText: '*',
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      validator: (val) => val.isEmpty ? 'Vul hier een naam in' : null,
                      initialValue: name,
                      autocorrect: false,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    DateTimeField(
                      resetIcon: null,
                      format: DateFormat("d MMMM yyyy, HH:mm"),
                      initialValue: stopdate,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Wanneer heb je voor het laatst gedronken?',
                        alignLabelWithHint: true,
                        hintMaxLines: 2,
                      ),
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
                          return stopdate = DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Hoeveel geld gaf je per week uit aan alcohol?',
                        alignLabelWithHint: true,
                        hintMaxLines: 2,
                        prefixText: '€ ',
                      ),
                      initialValue: geld.toString(),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (val) {
                        setState(() {
                          geld = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Hoeveel bier dronk je gemiddeld per week?',
                          alignLabelWithHint: true,
                          hintMaxLines: 2,
                          suffixText: ' biertjes'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (val) => val.isEmpty ? 'Vul een aantal biertjes in' : null,
                      initialValue: bier.toString(),
                      onChanged: (val) {
                        setState(() => bier = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Hoeveel wijn dronk je gemiddeld per week?',
                          alignLabelWithHint: true,
                          hintMaxLines: 2,
                          suffixText: ' wijntjes'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (val) => val.isEmpty ? 'Vul een aantal wijntjes in' : null,
                      initialValue: wijn.toString(),
                      onChanged: (val) {
                        setState(() => wijn = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Hoeveel sterke drank dronk je gemiddeld per week?',
                          alignLabelWithHint: true,
                          hintMaxLines: 2,
                          suffixText: ' glazen'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val.isEmpty ? 'Vul een aantal glazen sterke drank in' : null,
                      initialValue: wijn.toString(),
                      onChanged: (val) {
                        setState(() => sterk = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Hoeveel katers had je gemiddeld per MAAND?',
                          alignLabelWithHint: true,
                          hintMaxLines: 2,
                          suffixText: ' katers'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (val) => val.isEmpty ? 'Vul een aantal katers in' : null,
                      initialValue: katers.toString(),
                      onChanged: (val) {
                        setState(() => katers = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: 'E-mailadres voor je account',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'E-mail',
                        suffixText: '*',
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        alignLabelWithHint: true,
                        hintMaxLines: 2,
                      ),
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val.isEmpty ? 'Vul alsjeblieft een e-mailadres in voor je account' : null,
                      initialValue: email,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Kies een wachtwoord',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'wachtwoord',
                        suffixText: '*',
                        suffixStyle: TextStyle(
                          color: Colors.red,
                        ),
                        alignLabelWithHint: true,
                        hintMaxLines: 2,
                      ),
                      validator: (val) =>
                          val.length < 8 ? 'Kies een wachtwoord van minstens 8 karakters' : null,
                      obscureText: true,
                      initialValue: password,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Aanmelden',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password)
                              .then((user) async {
                            await DatabaseService(uid: user.uid).updateUserData(
                              name,
                              stopdate,
                              geld,
                              bier,
                              wijn,
                              sterk,
                              katers,
                            );
                            print(user);
                            return user;
                            //await user.reload(); //reload  user data
                          });
                          if (result == null) {
                            setState(() {
                              error = 'Controleer het formulier nog eens';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
