import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:jiffy/jiffy.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

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
            // var minuten = Jiffy().diff(userData.stopdate, Units.MINUTE);
            // var uren = Jiffy().diff(userData.stopdate, Units.HOUR);
            // var dagen = Jiffy().diff(userData.stopdate, Units.DAY);
            // var weken = Jiffy().diff(userData.stopdate, Units.WEEK);
            // var maanden = Jiffy().diff(userData.stopdate, Units.MONTH);
            // var maandenrest = Jiffy().diff(userData.stopdate, Units.MONTH, true) -
            //     Jiffy().diff(userData.stopdate, Units.MONTH);
            // var jaren = Jiffy().diff(userData.stopdate, Units.YEAR);
            // String tijdstring;

            // if (jaren > 0) {
            //   tijdstring =
            //       'Ruim $jaren jaar en ${maanden - jaren * 12} maanden en ${(maandenrest * 31).floor()} dagen! \n\nWie had dat gedacht? Geniet van je welverdiende alcoholvrijheid!';
            // } else if (maanden > 1) {
            //   tijdstring =
            //       'Dat zijn al $maanden maanden en ${(maandenrest * 31).floor()} dagen, oftewel ruim $weken weken! Hoe briljant is dat?!';
            // } else if (maanden == 1) {
            //   tijdstring =
            //       'Dat is al 1 maand en ${(maandenrest * 31).floor()} dagen, oftewel ruim $weken weken! Hoe briljant is dat?!';
            // } else if (weken > 1) {
            //   tijdstring = 'Dat zijn al ruim $weken weken. Ga zo door!';
            // } else if (weken == 1) {
            //   tijdstring = 'Dat is al 1 week en ${dagen - 7} dagen. Lekker hoor!';
            // } else if (weken == 0 && dagen > 0) {
            //   tijdstring =
            //       'Dat zijn dus maar mooi $dagen dagen en ${uren - (dagen * 24)} uren zonder drank! Heerlijk bezig hoor, hou dit vol!!';
            // } else {
            //   tijdstring =
            //       'Dat is dus al mooi $uren uur en $minuten minuten zonder drank! Het begin van een mooi leven is daadwerkelijk aangebroken. Gefeliciteerd!';
            // }

            int stopdagen = DateTime.now().difference(userData.stopdate).inDays;
            return Container(
              margin: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
              child: ListView(
                children: [
                  Card(
                    elevation: 7.0,
                    child: InkWell(
                      //splashColor: Colors.amberAccent,
                      //onTap: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     // return object of type Dialog
                      //     return AlertDialog(
                      //       title: new Text('Of beter gezegd...'),
                      //       // content: new Text(
                      //       //     '$jaren jaar\n$maanden maanden\n$weken weken\n$dagen dagen\n$uren uren\n$minuten minuten'),
                      //       content: Text(tijdstring),
                      //       actions: <Widget>[
                      //         // usually buttons at the bottom of the dialog
                      //         new FlatButton(
                      //           child: new Text("Geweldig!"),
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                      //},
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
                              child: stopdagen == 1
                                  ? Text(
                                      '$stopdagen dag',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 31,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      '$stopdagen dagen',
                                      style: TextStyle(
                                        fontFamily: 'Heebo',
                                        fontSize: 27,
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
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
                          child: InkWell(
                            // onTap: () {
                            //   AwesomeDialog(
                            //     context: context,
                            //     dialogType: DialogType.SUCCES,
                            //     animType: AnimType.TOPSLIDE,
                            //     title: 'Of beter gezegd...',
                            //     desc: tijdstring,
                            //     //btnCancelOnPress: () {},
                            //     btnOkText: 'Geweldig!',
                            //     btnOkIcon: Icons.thumb_up,
                            //     btnOkColor: Colors.amber,
                            //     btnOkOnPress: () {},
                            //   )..show();
                            // },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('Daarmee heb je al'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '€ ${format.format(stopdagen * (userData.geld / 7))}',
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
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
                          child: InkWell(
                            // onTap: () {
                            //   AwesomeDialog(
                            //     context: context,
                            //     dialogType: DialogType.WARNING,
                            //     animType: AnimType.SCALE,
                            //     btnOkText: 'Geweldig!',
                            //     title: 'Of beter gezegd...',
                            //     desc: tijdstring,
                            //     btnCancelOnPress: () {},
                            //     btnOkOnPress: () {},
                            //   )..show();
                            // },
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
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 10.0,
                          child: InkWell(
                            // onTap: () {
                            //   AwesomeDialog(
                            //     context: context,
                            //     dialogType: DialogType.SUCCES,
                            //     animType: AnimType.TOPSLIDE,
                            //     title: 'Of beter gezegd...',
                            //     desc: tijdstring,
                            //     btnCancelOnPress: () {},
                            //     btnOkOnPress: () {},
                            //   )..show();
                            // },
                            // splashColor: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('En je hebt zeker'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${(stopdagen * ((userData.bier + userData.wijn + userData.sterk) / 7)).round()}',
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
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 10.0,
                          child: InkWell(
                            // onTap: () {
                            //   AwesomeDialog(
                            //     context: context,
                            //     dialogType: DialogType.SUCCES,
                            //     animType: AnimType.SCALE,
                            //     title: 'Of beter gezegd...',
                            //     desc: tijdstring,
                            //     btnCancelOnPress: () {},
                            //     btnOkOnPress: () {},
                            //   )..show();
                            // },
                            // splashColor: Colors.amberAccent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 20, 7, 20),
                              child: Column(
                                children: [
                                  Text('Bij elkaar is dat'),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${(stopdagen * (((userData.bier * 0.250) + (userData.wijn * 0.125) + (userData.sterk * 0.035)) / 7)).round()}',
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
