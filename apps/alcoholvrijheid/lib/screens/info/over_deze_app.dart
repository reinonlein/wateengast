import 'package:flutter/material.dart';
import 'package:about/about.dart';

class OverDezeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutPage(
      title: Text('Over deze app'),
      applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
      applicationDescription: Text(
        'Deze app is met veel liefde in mijn vrije tijd gemaakt door ReinOnlein: datanerd, schrijver en ex-pilsfanaat in hart en nieren. In de gereedschapskoffer voor deze app zitten Flutter, Dart, Firebase en natuurlijk mijn lievelingseditor Visual Studio Code. Aan al deze tools: bedankt! Jullie zijn werkelijk fantastisch :-)',
        textAlign: TextAlign.justify,
      ),
      applicationIcon: FlutterLogo(size: 100),
      applicationLegalese: '© ReinOnlein, Alcoholvrijheid {{ year }}',
      children: <Widget>[
        MarkdownPageListTile(
          filename: 'README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
        ),
        MarkdownPageListTile(
          filename: 'changelog.md',
          title: Text('View Changelog'),
          icon: Icon(Icons.view_list),
        ),
        MarkdownPageListTile(
          filename: 'plugins.md',
          title: Text('Gebruikte plugins'),
          icon: Icon(Icons.description),
        ),
        // MarkdownPageListTile(
        //   filename: 'LICENSE.md',
        //   title: Text('View License'),
        //   icon: Icon(Icons.description),
        // ),
        // MarkdownPageListTile(
        //   filename: 'CONTRIBUTING.md',
        //   title: Text('Contributing'),
        //   icon: Icon(Icons.share),
        // ),
        // MarkdownPageListTile(
        //   filename: 'CODE_OF_CONDUCT.md',
        //   title: Text('Code of conduct'),
        //   icon: Icon(Icons.sentiment_satisfied),
        // ),
        LicensesPageListTile(
          title: Text('Open source Licenses'),
          icon: Icon(Icons.favorite),
        ),
      ],
    );

    // Container(
    //   padding: EdgeInsets.all(30),
    //   child: Center(
    //     child: Text(
    //       'Deze app is jouw steuntje in de rug naar een heerlijk alcoholvrij leven. Met ervaringsverhalen, tips, voordelen, alternatieve drankjes en leuke statistiekjes over jouw alcoholvrijheid, zorgen we er samen voor dat je straks niets anders meer wilt Deze app gaat je helpen om eindelijk eens écht alcoholvrij door het leven te gaan. Niet omdat het moet, maar juist omdat je dat wilt!',
    //       textAlign: TextAlign.justify,
    //     ),
    //   ),
    // ),
  }
}
