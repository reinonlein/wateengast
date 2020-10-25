import 'package:alcoholvrijheid/screens/info/over_alcoholvrijheid.dart';
import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'package:http/http.dart' as http;

String changelog;
String readme;

Future<String> _getChangelog() async {
  final responseChangelog = await http.get(
      'https://raw.githubusercontent.com/reinonlein/wateengast/master/apps/alcoholvrijheid/CHANGELOG.md');
  return responseChangelog.body;
}

Future<String> _getReadme() async {
  final responseReadme = await http.get(
      'https://raw.githubusercontent.com/reinonlein/wateengast/master/apps/alcoholvrijheid/README.md');
  return responseReadme.body;
}

class OverDezeApp extends StatefulWidget {
  @override
  _OverDezeAppState createState() => _OverDezeAppState();
}

class _OverDezeAppState extends State<OverDezeApp> {
  @override
  void initState() {
    _getChangelog().then((changelogResult) {
      setState(() {
        changelog = changelogResult;
      });
    });

    _getReadme().then((readmeResult) {
      setState(() {
        readme = readmeResult;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AboutPage(
      title: Text('Over deze app'),
      applicationVersion: 'Versie {{ version }}, release #{{ buildNumber }}',
      applicationDescription: Text(
        'Deze app is met veel liefde en vrije tijd gemaakt door Rein: datanerd, schrijver en ex-pilsfanaat in hart en nieren. Deze app is gemaakt met Flutter, Dart, Firebase en natuurlijk mijn lievelingseditor VS Code. Aan al deze tools: bedankt! Jullie zijn werkelijk fantastisch :-)',
        textAlign: TextAlign.justify,
      ),
      applicationIcon: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: const SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: AssetImage('av-icon-text-klein.png'),
          ),
        ),
      ),
      applicationLegalese: '© ReinOnlein, Alcoholvrijheid {{ year }}',
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('Wat is er nieuw?'),
            leading: Icon(Icons.view_list),
            onTap: () {
              Navigator.pushNamed(context, '/changelog');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: MarkdownPageListTile(
            filename: 'README.md',
            title: Text('Github Readme'),
            icon: Icon(Icons.all_inclusive),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: MarkdownPageListTile(
            filename: 'plugins.md',
            title: Text('Gebruikte plugins'),
            icon: Icon(Icons.power),
          ),
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: LicensesPageListTile(
            title: Text('Open source Licenses'),
            icon: Icon(Icons.favorite),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: MarkdownPageListTile(
            filename: changelog,
            title: Text('Changelog'),
            icon: Icon(Icons.view_list),
          ),
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
