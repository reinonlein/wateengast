import 'package:alcoholvrijheid/main.dart';
import 'package:alcoholvrijheid/models/prestatietargets.dart';
import 'package:alcoholvrijheid/services/notificationService.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final List<Map> prestaties = PrestatieTargets().prestatietargets;

void notificationScheduler(stopdate, bier, wijn, sterk, geld, katers) async {
  turnOffNotifications();
  for (var i = 0; i < prestaties.length; i++) {
    if (prestaties[i]['eenheid'] == 'uren' &&
        tz.TZDateTime.from(stopdate, tz.local)
            .add(Duration(hours: prestaties[i]['target']))
            .isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
          flutterLocalNotificationsPlugin,
          i,
          'Gefeliciteerd: ${prestaties[i]['title']}!',
          prestaties[i]['content'].substring(0, 100),
          tz.TZDateTime.from(stopdate, tz.local).add(Duration(hours: prestaties[i]['target'])));
    } else if (prestaties[i]['eenheid'] == 'maanden' &&
        tz.TZDateTime.from(Jiffy(stopdate).add(months: prestaties[i]['target']), tz.local)
            .isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
        flutterLocalNotificationsPlugin,
        i,
        'Gefeliciteerd: ${prestaties[i]['title']}!',
        prestaties[i]['content'].length < 100
            ? prestaties[i]['content']
            : prestaties[i]['content'].substring(0, 100),
        tz.TZDateTime.from(Jiffy(stopdate).add(months: prestaties[i]['target']), tz.local),
      );
    } else if (prestaties[i]['eenheid'] == 'euro' &&
        tz.TZDateTime.from(
                Jiffy(stopdate).add(hours: (prestaties[i]['target'] / (geld / (7 * 24))).round()),
                tz.local)
            .isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
        flutterLocalNotificationsPlugin,
        i,
        'Gefeliciteerd: ${prestaties[i]['title']}!',
        prestaties[i]['content'].length < 100
            ? prestaties[i]['content']
            : prestaties[i]['content'].substring(0, 100),
        tz.TZDateTime.from(
            Jiffy(stopdate).add(hours: (prestaties[i]['target'] / (geld / (7 * 24))).round()),
            tz.local),
      );
    } else if (prestaties[i]['eenheid'] == 'liter' &&
        tz.TZDateTime.from(
                Jiffy(stopdate).add(
                    hours: (prestaties[i]['target'] /
                            ((bier * 0.3).round() +
                                    (wijn * 0.125).round() +
                                    (sterk * 0.035).round())
                                .round() *
                            7 *
                            24)
                        .round()),
                tz.local)
            .isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
        flutterLocalNotificationsPlugin,
        i,
        'Gefeliciteerd: ${prestaties[i]['title']}!',
        prestaties[i]['content'].length < 100
            ? prestaties[i]['content']
            : prestaties[i]['content'].substring(0, 100),
        tz.TZDateTime.from(
            Jiffy(stopdate).add(
                hours: (prestaties[i]['target'] /
                        ((bier * 0.3).round() + (wijn * 0.125).round() + (sterk * 0.035).round())
                            .round() *
                        7 *
                        24)
                    .round()),
            tz.local),
      );
    } else if (prestaties[i]['eenheid'] == 'katers' &&
        tz.TZDateTime.from(
                Jiffy(stopdate).add(days: (prestaties[i]['target'] / (katers / 30.5)).floor()),
                tz.local)
            .isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
        flutterLocalNotificationsPlugin,
        i,
        'Gefeliciteerd: ${prestaties[i]['title']}!',
        prestaties[i]['content'].length < 100
            ? prestaties[i]['content']
            : prestaties[i]['content'].substring(0, 100),
        tz.TZDateTime.from(
            Jiffy(stopdate).add(days: (prestaties[i]['target'] / (katers / 30.5)).floor()),
            tz.local),
      );
    }
  }
}

void turnOffNotifications() {
  turnOffNotification(flutterLocalNotificationsPlugin);
}
