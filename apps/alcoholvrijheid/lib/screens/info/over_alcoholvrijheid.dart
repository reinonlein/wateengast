import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class OverAlcoholvrijheid extends StatefulWidget {
  @override
  _OverAlcoholvrijheidState createState() => _OverAlcoholvrijheidState();
}

String markdown = '';

Future<String> _getMarkdown() async {
  final responseMarkdown = await http.get(
      'https://raw.githubusercontent.com/reinonlein/wateengast/master/apps/alcoholvrijheid/FAQ.md');
  return responseMarkdown.body;
}

class _OverAlcoholvrijheidState extends State<OverAlcoholvrijheid> {
  @override
  void initState() {
    _getMarkdown().then((result) {
      markdown = result;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Over Alcoholvrijheid'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Markdown(
          data: markdown,
          styleSheet:
              MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(textScaleFactor: 1.18),
          onTapLink: (url) {
            launch(url);
          },
        ),
      ),
    );
  }
}
