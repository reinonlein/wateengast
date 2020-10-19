import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class OverAlcoholvrijheid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Over Alcoholvrijheid'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('FAQ.md'),
            builder: (context, snapshot) {
              return Markdown(
                data: snapshot.data,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(textScaleFactor: 1.18),
                onTapLink: (url) {
                  launch(url);
                },
              );
            }),
      ),
    );
    //body: MarkdownBody(data: 'README.md'),

    // ListView(
    //   children: [
    //     // MarkdownPage(filename: 'README.md', title: Text('dude')),
    //     Html(
    //       style: {
    //         "html": Style(
    //           padding: EdgeInsets.fromLTRB(22, 22, 17, 22),
    //           fontSize: FontSize(16),
    //           //fontWeight: FontWeight.w400,
    //           letterSpacing: 0.2,
    //           //textAlign: TextAlign.justify,
    //         ),
    //       },
    //       data:
    //           '<h1>Alcoholvrijheid:</h1><h2>Omdat stoppen met alcohol ook gewoon leuk kan zijn!</h2><br><br>Welkom in de app van Alcoholvrijheid! Deze app is een zelfgemaakte, mobiele versie van de online versie op <a href="https://www.alcoholvrijheid.nl">Alcoholvrijheid.nl</a>, uitgebreid met een kekke alcoholvrij-stoptracker en nog talloze gave nieuwe features in de pijplijn. Omdat natuurlijk lang niet iedereen bekend is met Alcoholvrijheid, hier een simpele FAQ om het een en ander te verhelderen.<br><br><h3>Waar gaat Alcoholvrijheid over?</h3>Alcoholvrijheid gaat over (je raadt het al) de vrijheid van een alcoholvrij leven, en alles wat daarbij komt kijken. De term alcoholvrijheid is verzonnen voor het besef dat je ook los kunt van de gewenning en de enorme vrijheid die je daar dan vervolgens voor terug krijgt. Alcoholvrijheid staat voor een andere mindset, waarin je niet alleen maar denk te kunnen ontspannen met een drankje erbij. Het is een omslag die je enorm veel op kan leveren, als je die spannende stap eenmaal hebt genomen. Want kan een leven zonder alcohol wel leuk zijn? (Spoiler alert: jazeker!)<br><br><h3>Wat is het doel van Alcoholvrijheid?</h3>Het doel is om meer mensen te overtuigen om ook eens een keertje de rem van hun leven te halen. Ik ben ervan overtuigd dat de voordelen van stoppen de nadelen zwaar overtreffen, en als ik ook maar 1 iemand kan inspireren om ook die spannende stap te nemen is mijn missie meer dan geslaagd.<br><br><h3>Is dit weer zo’n wazige zelfhulp-site?</h3>Nee, dat is zeker niet de insteek. Er zijn genoeg websites te vinden over stoppen mer alcohol, verslaving en de schadelijke effecten die drank kan hebben, maar daar gaat deze website niet (primair) over. Deze website heeft juist een positieve insteek, waarin ik de vele voordelen van een alcoholvrij leven met jullie wil delen.<br><br><h3>Is Alcoholvrijheid van een organisatie?</h3>Nee, zeker niet. Alcoholvrijheid is op geen enkele manier gelieerd aan een of andere organisatie of overheid. Hij is puur in het leven geroepen uit blijheid en enthousiasme voor dit onderwerp. Alcoholvrijheid is dan ook een eenmansinitiatief, spontaan begonnen in de bus naar werk in mei 2019. Waarom ook niet?<br><br><h3>Huh, een eenmansinitiatief? Hoe dan?</h3>De inhoud wordt (vooralsnog alleen) geschreven door mij: Rein, een gast van 36 uit Haarlem. Omdat ik er heel veel plezier uit haal om te schrijven, ben ik in 2018 begonnen om elke dag wat leuks te schrijven voor mijn andere ambitieuze website <a href=https://www.wateengast.nl>Wateengast.nl</a>. Sinds ik zelf op oud en nieuw van 2018 voor een jaartje was gestopt met alcohol, had ik namelijk plotseling alle tijd, energie en motivatie om dit elke dag te doen. En omdat ik daar zo trots op was, schreef ik daar na een jaar dit verhaal over. Dat verhaal sloeg verrassend goed aan, en dus wilde ik kijken of ik daar niet eens wat meer mee zou kunnen doen.<br><br><h3>Maar wie is Rein?</h3>Ik ben dus Rein, online te vinden onder het pseudoniem Rein Onlein. Ik heb een gezinnetje met 2 kleine jochies en een baan als zogenaamde Data Scientist bij de grootste luchthaven van Nederland. Ik hou van programmeren en ik schrijf graag, wat best een gouden combinatie is al zeg ik het zelf. Dat betekent namelijk dat ik zelf bijvoorbeeld een complete app kan ontwikkelen, die ik daarna ook nog eens zelf helemaal van content kan voorzien. Alle touwtjes in handen, of om het tekstueel fout samen te vatten: The sky en the tijd are the limits.<br><br><h3>Wat kan je nog meer?</h3>Op mijn website <a href=https://www.reinonlein.nl>www.reinonlein.nl</a> kan je zien waar ik zoal mee gewerkt heb. Daar wil ik nog een portfolio en werkervaring aan toevoegen, in de hoop in de toekomst ook nog eens een leuke zzp opdracht uit mijn werk te slepen.<br><br><h3>Verdien je geld met Alcoholvrijheid?</h3>Nee, op dit moment nog niet. Althans, ik heb één keer 78 cent commissie gekregen op een boekverkoop via een affiliate link naar Bol.com, maar dat is alles. Maar dat is ook niet de insteek; mijn doel is om een leuk informatieplatform met hopelijk ooit een trouwe online gemeenschap op te bouwen. Mocht dat aanslaan, dan komt er vast een keer vanzelf een adverteerder op mijn pad. Wat ik in elk geval niet wil is mijn site verkopen voor banners en irritante in your face reclame. Ook wil ik deze app altijd reclamevrij en gratis aan blijven bieden, puur omdat ik daar zelf ook altijd zo\'n hekel aan heb. Ik overweeg wel om een keer een vrijblijvende donatie-knop in te gaan bouwen, maar hoe en wat moet ik nog even over nadenken.<br><br><h3>Schrijf je alle teksten voor Alcoholvrijheid zelf?</h3>Op dit moment grotendeels wel. De enige uitzondering zijn de ervaringsverhalen. Daar heb ik de grote eer dat andere mensen natuurlijk zelf hun antwoorden op de vragen op papier zetten. Aan mij rest dan de simpele taak om de boel wat te redigeren, kopiëren, anonimiseren en publiceren. Volle credits voor de auteurs dus! Maar ja, daarnaast komt alles uit eigen pen.<br><br><h3>Mag ik je teksten gebruiken op mijn website?</h3>Geen probleem, leuk zelfs, maar ik wil dan wel graag op de hoogte zijn en er een bronverwijzing naar <a href=https://www.alcoholvrijheid.nl>https://www.alcoholvrijheid.nl</a> voor terug. Op die manier heb ik er ook nog profijt van in de algoritmes van de grote zoekmachines<br><br><h3>Kan ik ook schrijven voor Alcoholvrijheid?</h3>Heel graag! Het lijkt me leuk als mensen als gastblogger willen bijdragen aan dit platform. Stuur me even een berichtje en we maken er werk van!<br><br><h3>Hoe kan ik contact met je opnemen?</h3>Mocht je iets te vragen hebben over Alcoholvrijheid, heb je een tip, een idee, suggestie, voorstel of een klacht: dan kan je me het beste mailen op <a href="mailto:info@lcoholvrijheid.nl">info@alcoholvrijheid.nl</a>. Ik neem dan zo snel mogelijk contact met je op!<br><br><h3>Wat staat er in de planning voor de toekomst?</h3>Qua content wil ik de komende tijd vooral inzetten op de ervaringsverhalen. Ik merk dat die het leukst zijn om te doen en ik denk dat lezers daar ook het meest aan zullen hebben. Voor de app staan er nog heel veel nieuwe features op mijn verlanglijst. Die lijst ga ik nog publiceren, maar bovenaan staan in elk geval deze toepassingen:<br><br>- Dat je een dagboek bij kunt houden<br>- Stemmingstracker<br>- Reminders waarom je ook alweer wilde stoppen<br>- Eventueel een chatbox/forum<br>- Een sociaal element, waarin je je stopmaatjes kunt ondersteunen<br>- Stem op nieuwe features<br>- Prestaties vrijspelen<br>- Vergelijkingen op stoptijd, geld, etc.<br>- Diverse performance en layout verbeteringen<br><br><h3>Tot zover voor nu!</h3>Mocht je vraag hier niet tussenstaan: <a href="mailto:info@lcoholvrijheid.nl">info@alcoholvrijheid.nl</a> is je vriend. En in de tussentijd: veel plezier met deze app en succes met je reis naar een heerlijk leven in pure alcoholvrijheid!',
    //       onLinkTap: (url) async {
    //         if (await canLaunch(url)) {
    //           await launch(url, forceWebView: false);
    //         } else {
    //           throw 'Could not launch $url';
    //         }
    //       },
    //     ),
    //   ],
    // ),
  }
}
