import 'package:flutter/material.dart';
import 'package:teamdiet/graphs/datetimecombochart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map dummyData = ({'Name': 'Rein', 'loss': '-0.7'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome to your Team Diet!'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text('Hier komt een grafiek'),
            ),
            Container(
              height: 220,
              padding: EdgeInsets.all(15),
              child: DateTimeComboLinePointChart.withSampleData(),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Rein'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  ListTile(
                    title: Text('Floor'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  ListTile(
                    title: Text('Lori'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  ListTile(
                    title: Text('Jordi'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  ListTile(
                    title: Text('Bote'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  ListTile(
                    title: Text('Yvon'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                    ),
                    trailing: Text('-0,7kg'),
                    subtitle: LinearProgressIndicator(
                      value: 0.35,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
