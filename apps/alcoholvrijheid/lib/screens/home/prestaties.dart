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
          int stopdagen = DateTime.now().difference(userData.stopdate).inDays;
          return Scaffold(
            appBar: AppBar(
              title: Text('Mijn prestaties'),
            ),
            body: ListView.separated(
                itemCount: prestaties.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return new ListTile(
                    leading: Icon(
                      Icons.emoji_events,
                      color:
                          stopdagen > prestaties[index]['target'] ? Colors.amber : Colors.grey[300],
                      size: 47,
                    ),
                    title: Text(prestaties[index]['title']),
                    subtitle: stopdagen > prestaties[index]['target']
                        ? Text(
                            'Gehaald op ${Jiffy(userData.stopdate.add(Duration(days: prestaties[index]['target']))).format("dd MMMM yyyy")}!',
                            style: TextStyle(color: Colors.grey),
                          )
                        : LinearProgressIndicator(
                            value: stopdagen / prestaties[index]['target'],
                            valueColor: AlwaysStoppedAnimation(Colors.green[200]),
                            backgroundColor: Colors.grey[300],
                          ),
                    onTap: () {
                      bool gehaald = stopdagen > prestaties[index]['target'];
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
                            : 'Je moet nog ${prestaties[index]['target'] - stopdagen} dagen volhouden om deze knappe prestatie vrij te spelen.',
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
                }),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

// body: Container(
//               padding: EdgeInsets.all(35),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.emoji_events_outlined,
//                           size: 65,
//                           color: Colors.grey[300],
//                         ),
//                         Icon(
//                           Icons.emoji_events,
//                           size: 65,
//                           color: Colors.amber,
//                         ),
//                       ],
//                     ),
//                     Text(
//                       'Hier komen zometeen alle vrij te spelen prestaties in een prachtige gridview van ${userData.name}. Op ${prestaties[0]['gehaald_op']}',
//                       style: TextStyle(fontSize: 22),
//                       textAlign: TextAlign.center,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.emoji_events_rounded,
//                           size: 65,
//                           color: Colors.grey[300],
//                         ),
//                         Icon(
//                           Icons.emoji_events_sharp,
//                           size: 65,
//                           color: Colors.amber,
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       prestaties[0]['gehaald'] ? Icons.emoji_events : Icons.emoji_events_outlined,
//                       size: 100,
//                       color: prestaties[0]['gehaald'] ? Colors.amber : Colors.grey[300],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
