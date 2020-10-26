import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:alcoholvrijheid/models/cardstrings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AlcoholvrijheidCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            NumberFormat format = NumberFormat("####0.00", "nl_NL");
            int stopdagen = DateTime.now().difference(userData.stopdate).inDays;
            int stopuren = DateTime.now().difference(userData.stopdate).inHours;
            int stopminuten = DateTime.now().difference(userData.stopdate).inMinutes;

            return Container(
              margin: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
              child: ListView(
                children: [
                  //////////// DAGEN NIET GEDRONKEN /////////////

                  Card(
                    elevation: 7.0,
                    child: InkWell(
                      splashColor: Colors.amberAccent,
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.SUCCES,
                          animType: AnimType.SCALE,
                          title:
                              'Je hebt al $stopdagen ${stopdagen == 1 ? 'dag' : 'dagen'} niet gedronken!',
                          desc: Cardstrings(userData: userData).tijdstring,
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: 'Goed bezig!',
                          btnOkIcon: Icons.thumb_up,
                          headerAnimationLoop: false,
                          btnOkColor: Colors.amber,
                          btnOkOnPress: () {},
                        )..show();
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                        child: Column(
                          children: [
                            Text('Welkom terug ${userData.name}!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                            SizedBox(height: 15.0),
                            Text('Je hebt op dit moment al'),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '$stopdagen ${stopdagen == 1 ? 'dag' : 'dagen'}',
                                style: TextStyle(
                                  fontFamily: 'Heebo',
                                  fontSize: 31,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('geen alcohol gedronken. Goed bezig!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      //////////// GELD BESPAARD /////////////

                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.SCALE,
                                title:
                                    'Nu al € ${(stopuren * (userData.geld / (7 * 24))).toStringAsFixed(2)} bespaard?',
                                desc: Cardstrings(userData: userData).geldstring,
                                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                                btnOkText: 'Briljant!',
                                btnOkIcon: Icons.thumb_up,
                                headerAnimationLoop: false,
                                btnOkColor: Colors.amber,
                                btnOkOnPress: () {},
                              )..show();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('Daarmee heb je al'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '€ ${format.format(stopuren * (userData.geld / (7 * 24)))}',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text('bespaard!'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),

                      //////////// KATERS NIET GEHAD /////////////
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.SCALE,
                                btnOkText: 'Heerlijk!',
                                title: 'Stel je voor zeg...',
                                desc: Cardstrings(userData: userData).katerstring,
                                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                                btnOkIcon: Icons.thumb_up,
                                headerAnimationLoop: false,
                                btnOkColor: Colors.amber,
                                btnOkOnPress: () {},
                              )..show();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('Nog beter, je hebt'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${(stopdagen * (userData.katers / 30)).round()}',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  (stopdagen * (userData.katers / 30)).round() == 1
                                      ? Text('kater niet gehad')
                                      : Text('katers niet gehad'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      //////////// DRANKJES NIET GEDRONKEN /////////////

                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.TOPSLIDE,
                                title: 'Of beter gezegd...',
                                desc: Cardstrings(userData: userData).drankjesstring,
                                btnOkColor: Colors.amber,
                                btnOkText: 'Lekker bezig!',
                                btnOkIcon: Icons.thumb_up_alt,
                                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 5.0),
                                btnOkOnPress: () {},
                                headerAnimationLoop: false,
                              )..show();
                            },
                            splashColor: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('En je hebt zeker'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${((stopuren / (7 * 24)) * (userData.bier + userData.wijn + userData.sterk)).round()}',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  (stopdagen *
                                                  ((userData.bier +
                                                          userData.wijn +
                                                          userData.sterk) /
                                                      7))
                                              .round() ==
                                          1
                                      ? Text('drankje laten staan')
                                      : Text('drankjes laten staan')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),

                      //////////// LITERS NIET GEDRONKEN /////////////

                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.SCALE,
                                title: 'Met andere woorden...',
                                desc: Cardstrings(userData: userData).literstring,
                                btnOkIcon: Icons.thumb_up_alt,
                                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 7.0),
                                btnOkColor: Colors.amber,
                                btnOkText: 'Geweldig!',
                                headerAnimationLoop: false,
                                btnOkOnPress: () {},
                              )..show();
                            },
                            splashColor: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('Bij elkaar is dat'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${((stopuren / (7 * 24)) * userData.bier * 0.250).round() + ((stopuren / (7 * 24)) * userData.wijn * 0.125).round() + ((stopuren / (7 * 24)) * userData.sterk * 0.035).round()}',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text('liter drank!'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
