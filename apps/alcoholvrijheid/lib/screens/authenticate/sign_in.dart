import 'package:alcoholvrijheid/services/auth.dart';
import 'package:alcoholvrijheid/shared/constants.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Colors.amber,
              elevation: 0.0,
              title: Text('Welkom terug!'),
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Aanmelden'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password)
                              .catchError((e) {
                            print(e);
                            setState(() {
                              error = e;
                              loading = false;
                            });
                          });
                          if (result == null) {
                            setState(() {
                              error =
                                  'Oeps! Het e-mailadres en/of wachtwoord klopt niet. Probeer het nog eens. \n\n Als je je wachtwoord vergeten bent kun je hieronder een nieuwe aanvragen.\nKom je er nog niet uit? Stuur dan een mailtje naar info@alcoholvrijheid.nl';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          headerAnimationLoop: false,
                          dialogType: DialogType.WARNING,
                          body: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                            child: Column(
                              children: [
                                Text(
                                  'Wachtwoord vergeten?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'Vul hier je e-mailadres in om een nieuw wachtwoord aan te vragen:',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                TextFormField(
                                  autofocus: true,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Vul hier je e-mailadres in:',
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintText: 'E-mail',
                                    alignLabelWithHint: true,
                                  ),
                                  autocorrect: false,
                                  onChanged: (val) {
                                    setState(() => email = val.trim());
                                  },
                                ),
                              ],
                            ),
                          ),
                          btnCancelOnPress: () {},
                          btnCancelText: 'Grapje',
                          btnOkText: 'Versturen',
                          btnOkOnPress: () async {
                            try {
                              await _auth.resetPassword(email.trim());
                              setState(() {
                                error =
                                    'Er is een link naar je verstuurd waarmee je een nieuw wachtwoord in kunt stellen';
                              });
                            } catch (e) {
                              setState(() {
                                error = 'Er is geen gebruiker bekend met dit e-mailadres';
                              });
                            }
                          },
                        )..show();
                      },
                      child: Text('Wachtwoord vergeten? Klik hier.'),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
