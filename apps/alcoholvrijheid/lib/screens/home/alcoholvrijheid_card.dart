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
                            child: Text(
                              '$stopdagen dagen', //TODO: conditional voor 1 dag
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.w600,
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
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
                                Text('En je hebt zeker'),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '${(stopdagen * ((userData.bier + userData.wijn + userData.sterk) / 7)).round()}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text('drankjes laten staan')
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text('katers niet gehad'),
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
                                Text('Oftewel'),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '${(stopdagen * (((userData.bier * 0.33) + (userData.wijn * 0.25) + (userData.sterk * 0.1)) / 7)).round()}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text('liter drank'),
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
