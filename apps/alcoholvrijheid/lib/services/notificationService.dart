import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

// Voorbeelden: https://github.com/brains-and-beards/flutter-reminders-app, https://github.com/MaikuB/flutter_local_notifications/tree/master/flutter_local_notifications/example

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject
            .add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
}

Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'AV1', 'Alcoholvrijheid', 'Alcoholvrijheid-channel',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      1, 'Wat een gast!', 'Je hebt weer een notificatie ontvangen.', platformChannelSpecifics,
      payload: '1');
}

Future<void> turnOffNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> turnOffNotificationById(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, num id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    int id, String title, String body, DateTime scheduledNotificationDateTime) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledNotificationDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails('AV1', 'Alcoholvrijheid', 'Alcoholvrijheid-channel'),
      ),
      androidAllowWhileIdle: true,
      payload: id.toString(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
}

Future<void> checkPendingNotificationRequests(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, context) async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pendingNotificationRequests[index].title),
            subtitle: Text(pendingNotificationRequests[index].payload),
          );
        },
        itemCount: pendingNotificationRequests.length,
      ),
      // Text(
      //     '${pendingNotificationRequests.length} pending notification requests\n\n${pendingNotificationRequests[0].title}'),

      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> scheduleNotificationPeriodically(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String id,
    String body,
    RepeatInterval interval) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    id,
    'Reminder notifications',
    'Remember about it',
    icon: 'smile_icon',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      0, 'Reminder', body, interval, platformChannelSpecifics);
}

void requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}
