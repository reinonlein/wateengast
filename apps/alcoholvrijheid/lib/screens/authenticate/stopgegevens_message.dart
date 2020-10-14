import 'package:flutter/material.dart';

class StopgegevensMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text('Log in om hier je\nstopgegevens te bewerken.',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center),
    ));
  }
}
