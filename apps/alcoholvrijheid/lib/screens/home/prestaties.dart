import 'package:alcoholvrijheid/models/prestatietargets.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:alcoholvrijheid/services/database.dart';
import 'package:alcoholvrijheid/shared/loading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
          int liters = ((stopuren / (7 * 24)) * userData.bier * 0.3).round() +
              ((stopuren / (7 * 24)) * userData.wijn * 0.125).round() +
              ((stopuren / (7 * 24)) * userData.sterk * 0.035).round();
          int katers = (stopmaanden * userData.katers).floor();
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
                        size: 44,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopuren > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(hours: prestaties[index]['target'])).yMMMMd}',
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
                              : LiquidCircularProgressIndicator(
                                  value: stopuren / prestaties[index]['target'],
                                  valueColor: AlwaysStoppedAnimation(Colors.green[100]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                  center: Text(
                                      '${((stopuren / prestaties[index]['target']) * 100).round()} %',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${((prestaties[index]['target'] - stopuren) / 24).ceil()} ${((prestaties[index]['target'] - stopuren) / 24).ceil() == 1 ? 'dag' : 'dagen'} volhouden om deze prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.redAccent,
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
                        size: 44,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopmaanden > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(months: prestaties[index]['target'])).yMMMMd}',
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
                              : LiquidCircularProgressIndicator(
                                  value: stopmaanden / prestaties[index]['target'],
                                  valueColor: AlwaysStoppedAnimation(Colors.green[100]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                  center: Text(
                                      '${((stopmaanden / prestaties[index]['target']) * 100).round()} %',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${((prestaties[index]['target'] - stopmaanden) * 30.5).ceil()} ${((prestaties[index]['target'] - stopmaanden) * 30.5).ceil() == 1 ? 'dag' : 'dagen'} volhouden om deze prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.redAccent,
                          btnOkOnPress: () {},
                        )..show();
                      },
                    );
                  } else if (prestaties[index]['eenheid'] == 'liter') {
                    return ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color:
                            liters > prestaties[index]['target'] ? Colors.amber : Colors.grey[300],
                        size: 44,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: liters > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(hours: (prestaties[index]['target'] / ((userData.bier * 0.3).round() + (userData.wijn * 0.125).round() + (userData.sterk * 0.035).round()).round() * 7 * 24).round())).yMMMMd}',
                              style: TextStyle(color: Colors.grey),
                            )
                          : LinearProgressIndicator(
                              value: liters / prestaties[index]['target'],
                              valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                              backgroundColor: Colors.grey[300],
                            ),
                      onTap: () {
                        bool gehaald = liters > prestaties[index]['target'];
                        AwesomeDialog(
                          context: context,
                          customHeader: gehaald
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.asset('assets/trophygif.gif'),
                                )
                              : LiquidCircularProgressIndicator(
                                  value: liters / prestaties[index]['target'],
                                  valueColor: AlwaysStoppedAnimation(Colors.green[100]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                  center: Text(
                                      '${((liters / prestaties[index]['target']) * 100).round()} %',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${(prestaties[index]['target'] - liters).ceil()} ${(prestaties[index]['target'] - liters).ceil() == 1 ? 'liter' : 'liters'} laten staan om deze prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.redAccent,
                          btnOkOnPress: () {},
                        )..show();
                      },
                    );
                  } else if (prestaties[index]['eenheid'] == 'katers') {
                    return ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color:
                            katers > prestaties[index]['target'] ? Colors.amber : Colors.grey[300],
                        size: 44,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: katers > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(days: (prestaties[index]['target'] / (userData.katers / 30.5)).floor())).yMMMMd}',
                              style: TextStyle(color: Colors.grey),
                            )
                          : LinearProgressIndicator(
                              value: katers / prestaties[index]['target'],
                              valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                              backgroundColor: Colors.grey[300],
                            ),
                      onTap: () {
                        print(stopmaanden * 30.5);
                        bool gehaald = katers > prestaties[index]['target'];
                        AwesomeDialog(
                          context: context,
                          customHeader: gehaald
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90.0),
                                  child: Image.asset('assets/trophygif.gif'),
                                )
                              : LiquidCircularProgressIndicator(
                                  value: katers / prestaties[index]['target'],
                                  valueColor: AlwaysStoppedAnimation(Colors.green[100]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                  center: Text(
                                      '${((katers / prestaties[index]['target']) * 100).round()} %',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog ${prestaties[index]['target'] - katers} ${(prestaties[index]['target'] - katers) == 1 ? 'kater' : 'katers'} ontwijken om deze prestatie vrij te spelen.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.redAccent,
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
                        size: 44,
                      ),
                      title: Text(prestaties[index]['title']),
                      subtitle: stopuren * (userData.geld / (7 * 24)) > prestaties[index]['target']
                          ? Text(
                              'Gehaald op ${Jiffy(Jiffy(userData.stopdate).add(hours: (prestaties[index]['target'] / (userData.geld / (7 * 24))).round())).yMMMMd}',
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
                              : LiquidCircularProgressIndicator(
                                  value: stopuren *
                                      (userData.geld / (7 * 24)) /
                                      prestaties[index]['target'],
                                  valueColor: AlwaysStoppedAnimation(Colors.green[100]),
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.white,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                  center: Text(
                                      '${((stopuren * (userData.geld / (7 * 24)) / prestaties[index]['target']) * 100).round()} %',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                          dialogType: gehaald ? DialogType.SUCCES : DialogType.ERROR,
                          animType: AnimType.SCALE,
                          title: gehaald ? prestaties[index]['title'] : 'Nog even geduld...',
                          desc: gehaald
                              ? prestaties[index]['content']
                              : 'Je moet nog € ${((prestaties[index]['target'] - (stopuren * (userData.geld / (7 * 24))))).toStringAsFixed(2)} besparen om deze prestatie vrij te spelen.\n\nAls je zo doorgaat is dat over ${((((prestaties[index]['target'] - (stopuren * (userData.geld / (7 * 24)))) / (userData.geld / (7 * 24))).round()) / 24).round()} dagen op ${Jiffy(Jiffy(userData.stopdate).add(hours: (((prestaties[index]['target'] - (stopuren * (userData.geld / (7 * 24)))) / (userData.geld / (7 * 24))).round()))).yMMMMd}.',
                          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                          btnOkText: gehaald ? 'Wat een feest!' : 'Ah balen...',
                          btnOkIcon: gehaald
                              ? Icons.sentiment_very_satisfied
                              : Icons.sentiment_very_dissatisfied,
                          headerAnimationLoop: false,
                          isDense: false,
                          btnOkColor: gehaald ? null : Colors.redAccent,
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
