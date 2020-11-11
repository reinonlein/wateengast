import 'package:alcoholvrijheid/screens/home/home.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notificaties {
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '1 dag niet gedronken!',
        'Gefeliciteerd, je hebt 1 dag niet gedronken!', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> negenUurScheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String id,
      String body,
      DateTime scheduledNotificationDateTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Je hebt 9 uur niet gedronken!',
        'Gefeliciteerd, het is je gelukt om 9 uur geen alcohol te drinken!',
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 9)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> turnOffNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> turnOffNotificationById(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, num id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
