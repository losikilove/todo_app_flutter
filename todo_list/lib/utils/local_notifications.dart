import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize the local notifications
  Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  // show a simple notification
  // static Future showSimpleNotification(
  //     {required String title,
  //     required String body,
  //     required String payload}) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('2', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin
  //       .show(0, title, body, notificationDetails, payload: payload);

  //   print('$title');
  // }

  // // to show periodic notification at regular interval
  // static Future showPeriodicNotification(
  //     {required String title,
  //     required String body,
  //     required String payload}) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('channel 2', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await _flutterLocalNotificationsPlugin
  //       .show(0, title, body, notificationDetails, payload: payload);
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //       1, title, body, RepeatInterval.everyMinute, notificationDetails);
  // }

  // to schedule a local notification
  Future showScheduleNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime duration,
      String payload = ''}) async {
    tz.initializeTimeZones();
    // set timezone UTC+7 and show the notification on time (-10 minutes)
    tz.TZDateTime onTime = tz.TZDateTime.from(
        duration.subtract(const Duration(minutes: 10)),
        tz.getLocation('Asia/Bangkok'));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        onTime,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // close a specific notification
  Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  Future closeAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
