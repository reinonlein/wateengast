import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);

var faqItem = Html(
  style: {
    "html": Style(
      padding: EdgeInsets.all(0),
      fontSize: FontSize(16),
      //fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      //textAlign: TextAlign.justify,
    ),
  },
  data:
      '<h3>Huh, een eenmansinitiatief? Hoe dan?</h3>De inhoud wordt (vooralsnog alleen) geschreven door mij: Rein, een gast van 36 uit Haarlem. Omdat ik er heel veel plezier uit haal om te schrijven, ben ik in 2018 begonnen om elke dag wat leuks te schrijven voor mijn andere ambitieuze website <a href=https://www.wateengast.nl>Wateengast.nl</a>. Sinds ik zelf op oud en nieuw van 2018 voor een jaartje was gestopt met alcohol, had ik namelijk plotseling alle tijd, energie en motivatie om dit elke dag te doen. En omdat ik daar zo trots op was, schreef ik daar na een jaar dit verhaal over. Dat verhaal sloeg verrassend goed aan, en dus wilde ik kijken of ik daar niet eens wat meer mee zou kunnen doen.',
  onLinkTap: (url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  },
);

const drawerItemStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

const formTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
);

const faqSizedbox = SizedBox(
  height: 10,
);
