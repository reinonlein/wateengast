import 'package:flutter/material.dart';
import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';

class AlcoholvrijerdTile extends StatelessWidget {
  final Alcoholvrijerd alcoholvrijerd;
  AlcoholvrijerdTile({this.alcoholvrijerd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            //backgroundColor: Colors.brown[alcoholvrijerd.strength],
            backgroundColor: Colors.amber,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(alcoholvrijerd.name),
          subtitle: Text(
              '${DateTime.now().difference(alcoholvrijerd.stopdate).inDays} dagen alcoholvrij'),
        ),
      ),
    );
  }
}
