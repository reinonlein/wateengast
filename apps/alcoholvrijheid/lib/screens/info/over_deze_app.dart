import 'package:alcoholvrijheid/screens/home/home_drawer.dart';
import 'package:flutter/material.dart';

class OverDezeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Over deze app'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text(
            'Deze app is jouw steuntje in de rug naar een heerlijk alcoholvrij leven. Met ervaringsverhalen, tips, voordelen, alternatieve drankjes en leuke statistiekjes over jouw alcoholvrijheid, zorgen we er samen voor dat je straks niets anders meer wilt Deze app gaat je helpen om eindelijk eens écht alcoholvrij door het leven te gaan. Niet omdat het moet, maar juist omdat je dat wilt!',
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
