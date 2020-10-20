import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
            return Container(
              margin: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
              child: ListView(
                children: [
                  Card(
                    elevation: 7.0,
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
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
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 20,
                        child: Card(
                          elevation: 7.0,
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
                                (stopdagen * ((userData.bier + userData.wijn + userData.sterk) / 7))
                                            .round() ==
                                        1
                                    ? Text('drankje laten staan')
                                    : Text('drankjes laten staan')
                              ],
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
