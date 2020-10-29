import 'package:alcoholvrijheid/models/prestatietargets.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class Prestaties extends StatelessWidget {
  final List<Map> prestaties = PrestatieTargets().prestatietargets;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Jiffy.locale("nl");

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          int stopuren = Jiffy().diff(userData.stopdate, Units.HOUR);
          double stopmaanden = Jiffy().diff(userData.stopdate, Units.MONTH, true);
          return Scaffold(
            body: ListView.separated(
                itemCount: prestaties.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  if (prestaties[index]['eenheid'] == 'uren') {
                    return ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color: stopuren > prestaties[index]['target']
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 47,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopuren > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(userData.stopdate.add(Duration(hours: prestaties[index]['target']))).format("dd MMMM yyyy")}!',
                              style: TextStyle(color: Colors.grey),
                            )
                          : LinearProgressIndicator(
                              value: stopuren / prestaties[index]['target'],
                              valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                              backgroundColor: Colors.grey[300],
                            ),
                      onTap: () {
                        bool gehaald = stopuren > prestaties[index]['target'];
                        AwesomeDialog(
                          context: context,
                          customHeader: gehaald
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.asset('assets/trophygif.gif'),
                                )
                              : null,
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog heel even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${((prestaties[index]['target'] - stopuren) / 24).ceil()} ${((prestaties[index]['target'] - stopuren) / 24).ceil() == 1 ? 'dag' : 'dagen'} volhouden om deze knappe prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.red,
                          btnOkOnPress: () {},
                        )..show();
                      },
                    );
                  } else if (prestaties[index]['eenheid'] == 'maanden') {
                    return ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color: stopmaanden > prestaties[index]['target']
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 47,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopmaanden > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(months: prestaties[index]['target'])).yMMMMd}!',
                              style: TextStyle(color: Colors.grey),
                            )
                          : LinearProgressIndicator(
                              value: stopmaanden / prestaties[index]['target'],
                              valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                              backgroundColor: Colors.grey[300],
                            ),
                      onTap: () {
                        bool gehaald = stopmaanden > prestaties[index]['target'];
                        AwesomeDialog(
                          context: context,
                          customHeader: gehaald
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.asset('assets/trophygif.gif'),
                                )
                              : null,
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog heel even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${((prestaties[index]['target'] - stopmaanden) * 30.5).ceil()} ${((prestaties[index]['target'] - stopmaanden) * 30.5).ceil() == 1 ? 'dag' : 'dagen'} volhouden om deze knappe prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.red,
                          btnOkOnPress: () {},
                        )..show();
                      },
                    );
                  } else {
                    // dan zijn het euro's
                    return ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color: stopuren * (userData.geld / (7 * 24)) > prestaties[index]['target']
                            ? Colors.amber
                            : Colors.grey[300],
                        size: 47,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopuren * (userData.geld / (7 * 24)) > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(months: prestaties[index]['target'])).yMMMMd}!',
                              style: TextStyle(color: Colors.grey),
                            )
                          : LinearProgressIndicator(
                              value: stopuren *
                                  (userData.geld / (7 * 24)) /
                                  prestaties[index]['target'],
                              valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                              backgroundColor: Colors.grey[300],
                            ),
                      onTap: () {
                        bool gehaald =
                            stopuren * (userData.geld / (7 * 24)) > prestaties[index]['target'];
                        AwesomeDialog(
                          context: context,
                          customHeader: gehaald
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.asset('assets/trophygif.gif'),
                                )
                              : null,
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog heel even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${((prestaties[index]['target'] - (stopuren * (userData.geld / (7 * 24)))))} besparen om deze knappe prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.red,
                          btnOkOnPress: () {},
                        )..show();
                      },
                    );
                  }
                }),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
