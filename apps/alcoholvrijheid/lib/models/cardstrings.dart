import 'package:alcoholvrijheid/models/user.dart';
import 'package:jiffy/jiffy.dart';

class Cardstrings {
  //DateTime stopdate;
  UserData userData;

  int get stopdagen {
    return Jiffy().diff(userData.stopdate, Units.DAY);
  }

  String get geldstring {
    var stopuren = Jiffy().diff(userData.stopdate, Units.HOUR, true);
    int geld = userData.geld;
    String geldstring;

    if (stopuren * (geld / (7 * 24)) >= 50) {
      geldstring =
          'Lekker bezig! En voor die ${((stopuren * (geld / (7 * 24)))).floor()} euro kon je dus ook mooi ${((stopuren * (geld / (7 * 24))) / 15).round()} ${((stopuren * (geld / (7 * 24))) / 15).round() == 1 ? 'bosje' : 'bosjes'} bloemen voor jezelf kopen. Of ${((stopuren * (geld / (7 * 24))) / 50).round()} keer boodschappen doen! Of wat dacht je misschien van ${((stopuren * (geld / (7 * 24))) / 27).round()} keer naar de sauna?\n\nWat je ook wilt, iedere alcoholvrije dag bespaart geld. En dat is toch mooi meegenomen!';
    } else if (stopuren * (geld / (7 * 24)) >= 27) {
      geldstring =
          'Lekker bezig! En voor die ${((stopuren * (geld / (7 * 24)))).floor()} euro kon je dus ook mooi ${((stopuren * (geld / (7 * 24))) / 15).round()} ${((stopuren * (geld / (7 * 24))) / 15).round() == 1 ? 'bosje' : 'bosjes'} bloemen voor jezelf kopen. Of wat dacht je misschien van ${((stopuren * (geld / (7 * 24))) / 27).round()} keer naar de sauna?\n\nWat je ook wilt, iedere alcoholvrije dag bespaart geld. En dat is toch mooi meegenomen!';
    } else if (stopuren * (geld / (7 * 24)) >= 15) {
      geldstring =
          'Lekker bezig! En voor die ${((stopuren * (geld / (7 * 24)))).floor()} euro kon je dus ook mooi ${((stopuren * (geld / (7 * 24))) / 15).round()} ${((stopuren * (geld / (7 * 24))) / 15).round() == 1 ? 'bosje' : 'bosjes'} bloemen voor jezelf kopen!\n\nWat je ook wilt, iedere alcoholvrije dag bespaart geld. En dat is toch mooi meegenomen!';
    } else {
      geldstring =
          'Lekker bezig! Die ${((stopuren * (geld / (7 * 24)))).floor()} euro\'s zijn het begin van een klein kapitaal. Kleine tip: zet het geld apart en bedenk iets leuks om jezelf straks mee te belonen. Dat verdien je!';
    }

    return geldstring;
  }

  String get literstring {
    var stopuren = Jiffy().diff(userData.stopdate, Units.HOUR, true);
    int bier = userData.bier;
    int wijn = userData.wijn;
    int sterk = userData.sterk;
    String literstring;

    if (bier + wijn + sterk == 0) {
      literstring =
          'Je hebt niet ingevuld hoeveel je dronk voordat je stopte. Ga hieronder naar \'Mijn stopgegevens\' om dit in te vullen. Daarna kan je hier bijhouden hoeveel je hebt laten staan.';
    } else if (wijn + sterk == 0) {
      literstring =
          'Sinds je gestopt bent heb je al ${((stopuren / (7 * 24)) * bier * 0.3).round()} liter bier niet gedronken! \n\nStel je voor zeg, bij elkaar is dat dus gewoon ${((((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip vol bier!\n\nEn ook niet onbelangijk: dat ${(((stopuren / (7 * 24)) * bier * 0.3).ceil() / 7.2).ceil() == 1 ? 'is' : 'zijn'} dus ${(((stopuren / (7 * 24)) * bier * 0.3).ceil() / 7.2).toStringAsFixed(0)} ${(((stopuren / (7 * 24)) * bier * 0.3).ceil() / 7.2).ceil() == 1 ? 'leeg krat dat' : 'lege kratten die'} je mooi niet hoefde weg te brengen. Dat scheelt een hoop gesjouw. Lekker bezig!';
    } else if (bier + sterk == 0) {
      literstring =
          'Sinds je gestopt bent heb je al ${((stopuren / (7 * 24)) * wijn * 0.125).round()} liter wijn laten staan. \n\nStel je voor zeg, bij elkaar is dat dus gewoon ${((((stopuren / (7 * 24)) * wijn * 0.125).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip vol wijn!\n\nEn ook niet onbelangijk: dat zijn dus ${((stopuren / (7 * 24)) * wijn * 0.125).round()} ${((stopuren / (7 * 24)) * wijn * 0.125).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen naar de glasbak. Hoe relaxed!';
    } else if (bier + wijn == 0) {
      literstring =
          'Sinds je gestopt bent heb je al ${((stopuren / (7 * 24)) * sterk * 0.035).round()} liter sterke drank laten staan. \n\nStel je voor zeg, bij elkaar is dat dus gewoon ${((((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip vol sterke drank!\n\nEn ook niet onbelangijk: dat zijn dus ${((((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round()} ${((((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen naar de glasbak. Hoe relaxed!';
    } else if (bier == 0) {
      literstring =
          '${((stopuren / (7 * 24)) * wijn * 0.125).round()} liter wijn en ${((stopuren / (7 * 24)) * sterk * 0.035).round()} liter sterke drank... bij elkaar is dat ${((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()} liter drank.\n\nDat is ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip!\n\nEn ook niet onbelangijk: dat zijn dus ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round()} ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen naar de glasbak. Hoe relaxed!';
    } else if (wijn == 0) {
      literstring =
          '${((stopuren / (7 * 24)) * bier * 0.3).round()} liter bier en ${((stopuren / (7 * 24)) * sterk * 0.035).round()} liter sterke drank... bij elkaar is dat ${((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()} liter drank.\n\nDat is ${((((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip!\n\nEn ook niet onbelangijk: dat zijn dus ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).toStringAsFixed(0)} ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).round() == 1 ? 'krat' : 'kratten'} en ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round()} ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen!';
    } else if (sterk == 0) {
      literstring =
          '${((stopuren / (7 * 24)) * bier * 0.3).round()} liter bier en ${((stopuren / (7 * 24)) * wijn * 0.125).round()} liter wijn... bij elkaar is dat ${((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()} liter drank.\n\nDat is ${((((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip!\n\nEn ook niet onbelangijk: dat zijn dus ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).toStringAsFixed(0)} ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).round() == 1 ? 'krat' : 'kratten'} en ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round()} ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen!';
    } else {
      literstring =
          '${((stopuren / (7 * 24)) * bier * 0.3).round()} liter bier, ${((stopuren / (7 * 24)) * wijn * 0.125).round()} liter wijn en ${((stopuren / (7 * 24)) * sterk * 0.035).round()} liter sterke drank... bij elkaar is dat ${((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()} liter drank.\n\nDat is ${((((stopuren / (7 * 24)) * bier * 0.3).round() + ((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 120).toStringAsFixed(1)} keer een gemiddelde badkuip!\n\nEn ook niet onbelangijk: dat zijn dus ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).toStringAsFixed(0)} ${(((stopuren / (7 * 24)) * bier * 0.3).round() / 7.2).round() == 1 ? 'krat' : 'kratten'} en ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round()} ${((((stopuren / (7 * 24)) * wijn * 0.125).round() + ((stopuren / (7 * 24)) * sterk * 0.035).round()) / 0.750).round() == 1 ? 'fles' : 'flessen'} die je mooi niet hoefde weg te brengen!';
    }

    return literstring;
  }

  String get drankjesstring {
    var stopuren = Jiffy().diff(userData.stopdate, Units.HOUR, true);
    int bier = userData.bier;
    int wijn = userData.wijn;
    int sterk = userData.sterk;
    String drankjesstring;

    if (bier + wijn + sterk == 0) {
      drankjesstring =
          'Je hebt niet ingevuld hoeveel je dronk voordat je stopte. Ga hieronder naar \'Mijn stopgegevens\' om dit in te vullen. Daarna kan je hier bijhouden hoeveel je hebt laten staan.';
    } else if (wijn + sterk == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * bier).round()} biertjes laten staan. \n\nDat zijn wel mooi ${(((stopuren / (7 * 24)) * bier) / 6).floor() == 0 ? (((stopuren / (7 * 24)) * bier) / 6).toStringAsFixed(1) : (((stopuren / (7 * 24)) * bier) / 6).floor()} ${(((stopuren / (7 * 24)) * bier) / 6).floor() == 1 ? 'sixpackje' : 'sixpackjes'} of ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 0 ? (((stopuren / (7 * 24)) * bier) / 24).toStringAsFixed(1) : (((stopuren / (7 * 24)) * bier) / 24).floor()} ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'krat' : 'kratten'} bier!';
    } else if (bier + sterk == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * wijn).round()} ${((stopuren / (7 * 24)) * wijn).round() == 1 ? 'wijntje' : 'wijntjes'} laten staan. \n\nDat ${(((stopuren / (7 * 24)) * sterk) / 6).ceil() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * wijn) / 6).ceil()} ${(((stopuren / (7 * 24)) * wijn) / 6).ceil() == 1 ? 'fles' : 'flessen'} wijn die je hebt dichtgelaten!';
    } else if (bier + wijn == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * sterk).ceil()} ${((stopuren / (7 * 24)) * sterk).ceil() == 1 ? 'glas' : 'glazen'} sterke drank laten staan. \n\nDat ${(((stopuren / (7 * 24)) * sterk) / 18).ceil() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * sterk) / 18).ceil()} ${(((stopuren / (7 * 24)) * sterk) / 18).ceil() == 1 ? 'fles' : 'flessen'} sterke drank die je hebt dichtgelaten!';
    } else if (bier == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * wijn).round()} ${((stopuren / (7 * 24)) * wijn).round() == 1 ? 'wijntje' : 'wijntjes'} en ${((stopuren / (7 * 24)) * sterk).ceil()} ${((stopuren / (7 * 24)) * sterk).ceil() == 1 ? 'glas' : 'glazen'} sterke drank laten staan. \n\nDat ${(((stopuren / (7 * 24)) * sterk) / 6).ceil() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * wijn) / 6).ceil()} ${(((stopuren / (7 * 24)) * wijn) / 6).ceil() == 1 ? 'fles' : 'flessen'} wijn en ${(((stopuren / (7 * 24)) * sterk) / 18).ceil()} ${(((stopuren / (7 * 24)) * sterk) / 18).ceil() == 1 ? 'fles' : 'flessen'} sterke drank die je hebt dichtgelaten!';
    } else if (wijn == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * bier).round()} biertjes en ${((stopuren / (7 * 24)) * sterk).ceil()} ${((stopuren / (7 * 24)) * sterk).ceil() == 1 ? 'glas' : 'glazen'} sterke drank laten staan. \n\nDat ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 0 ? (((stopuren / (7 * 24)) * bier) / 24).toStringAsFixed(1) : (((stopuren / (7 * 24)) * bier) / 24).floor()} ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'krat' : 'kratten'} bier en ${(((stopuren / (7 * 24)) * sterk) / 18).ceil()} ${(((stopuren / (7 * 24)) * sterk) / 18).ceil() == 1 ? 'fles' : 'flessen'} sterke drank die je hebt overgeslagen!';
    } else if (sterk == 0) {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * bier).round()} biertjes en ${((stopuren / (7 * 24)) * wijn).ceil()} ${((stopuren / (7 * 24)) * wijn).ceil() == 1 ? 'wijntje' : 'wijntjes'} laten staan. \n\nDat ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 0 ? (((stopuren / (7 * 24)) * bier) / 24).toStringAsFixed(1) : (((stopuren / (7 * 24)) * bier) / 24).floor()} ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'krat' : 'kratten'} bier en ${(((stopuren / (7 * 24)) * wijn) / 6).ceil()} ${(((stopuren / (7 * 24)) * wijn) / 6).ceil() == 1 ? 'fles' : 'flessen'} wijn die je hebt overgeslagen!';
    } else {
      drankjesstring =
          'Sinds je gestopt bent heb je zeker ${((stopuren / (7 * 24)) * bier).round()} biertjes, ${((stopuren / (7 * 24)) * wijn).ceil()} ${((stopuren / (7 * 24)) * wijn).ceil() == 1 ? 'wijntje' : 'wijntjes'} en ${((stopuren / (7 * 24)) * sterk).ceil()} ${((stopuren / (7 * 24)) * sterk).ceil() == 1 ? 'glas' : 'glazen'} sterke drank laten staan.\n\nDat ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'is' : 'zijn'} wel mooi ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 0 ? (((stopuren / (7 * 24)) * bier) / 24).toStringAsFixed(1) : (((stopuren / (7 * 24)) * bier) / 24).floor()} ${(((stopuren / (7 * 24)) * bier) / 24).floor() == 1 ? 'krat' : 'kratten'} bier, ${(((stopuren / (7 * 24)) * wijn) / 6).ceil()} ${(((stopuren / (7 * 24)) * wijn) / 6).ceil() == 1 ? 'fles' : 'flessen'} wijn en ${(((stopuren / (7 * 24)) * sterk) / 18).ceil()} ${(((stopuren / (7 * 24)) * sterk) / 18).ceil() == 1 ? 'fles' : 'flessen'} sterke drank die je hebt overgeslagen!';
    }

    return drankjesstring;
  }

  String get katerstring {
    var stopdagen = Jiffy().diff(userData.stopdate, Units.DAY, true);
    int katers = userData.katers;
    String katerstring;

    if (katers == 0) {
      katerstring =
          'Volgens je gegevens had je voorheen nooit (meer) katers. Wat relaxed! In dat geval zullen je dus ook geen katers bespaard blijven en valt hier verder niet zoveel te zien. Mocht dit toch niet kloppen, dan kan je hieronder op \'Mijn stopgegevens\' tikken om je ouder aantal katers per maand in te vullen.';
    } else {
      katerstring =
          'Door te stoppen met alcohol heb je zeker ${(stopdagen * (katers / 30)).round()} ${(stopdagen * (katers / 30)).round() == 1 ? 'kater' : 'katers'} niet gehad! Kan je nagaan wat een tijd en energie je dat heeft opgeleverd?\n\nOm nog maar te zwijgen over alle pure ellendigheid die je nu niet hebt hoeven meemaken... Nee hoor, ga vooral zo door!';
    }

    return katerstring;
  }

  String get tijdstring {
    DateTime stopdate = userData.stopdate;
    var minuten = Jiffy().diff(stopdate, Units.MINUTE);
    var uren = Jiffy().diff(stopdate, Units.HOUR);
    var dagen = Jiffy().diff(stopdate, Units.DAY);
    var weken = Jiffy().diff(stopdate, Units.WEEK);
    var maanden = Jiffy().diff(stopdate, Units.MONTH);
    var maandenrest =
        Jiffy().diff(stopdate, Units.MONTH, true) - Jiffy().diff(stopdate, Units.MONTH);
    var jaren = Jiffy().diff(stopdate, Units.YEAR);
    String tijdstring;

    if (jaren > 0 && maanden == 0) {
      tijdstring =
          'Alweer $jaren jaar en ${(maandenrest * 31).floor()} ${(maandenrest * 31).floor() == 1 ? 'dag' : 'dagen'} zonder drank! \n\nWie had dat gedacht? Geniet van je welverdiende alcoholvrijheid!';
    } else if (jaren > 0) {
      tijdstring =
          'Alweer $jaren jaar, ${maanden - jaren * 12} ${(maanden - jaren * 12) == 1 ? 'maand' : 'maanden'} en ${(maandenrest * 31).floor()} ${(maandenrest * 31).floor() == 1 ? 'dag' : 'dagen'}! \n\nWie had dat gedacht? Geniet van je welverdiende alcoholvrijheid!';
    } else if (maanden > 1) {
      tijdstring =
          'Dat zijn al $maanden maanden en ${(maandenrest * 31).floor()} dagen, oftewel ruim $weken weken! Hoe briljant is dat?!';
    } else if (maanden == 1) {
      tijdstring =
          'Dat is al 1 maand en ${(maandenrest * 31).floor()} dagen, oftewel ruim $weken weken! Hoe briljant is dat?!';
    } else if (weken > 1) {
      tijdstring = 'Dat zijn al ruim $weken weken alcoholvrij. Ga zo door!';
    } else if (dagen > 7) {
      tijdstring = 'Dat is alweer 1 week en ${dagen - 7} dagen. Lekker hoor!';
    } else if (dagen == 7) {
      tijdstring = 'Je eerste week in alcoholvrijheid is een feit!\nOnvoorstelbaar gefeliciteerd!!';
    } else if (weken == 0 && dagen > 0) {
      tijdstring =
          'Dat is alweer $dagen ${dagen == 1 ? 'dag' : 'dagen'} en ${uren - (dagen * 24)} uur zonder drank! Heerlijk bezig hoor, hou dit vol!!';
    } else {
      tijdstring =
          'De kop is eraf! Je leeft nu al $uren uur en ${minuten - (uren * 60)} minuten alcoholvrij! Een mijlpaal om nooit te vergeten. Gefeliciteerd!';
    }

    return tijdstring;
  }

  Cardstrings({this.userData});
}
