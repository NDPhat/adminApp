import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../../main.dart';
import '../models/task_notify.dart';
import '../repo/notify_task/notoify_task_repo.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //
  initializeNotification() async {
    configTimeZone();
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    // await flutterLocalNotificationsPlugin.initialize(
    //     initializationSettings,
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    /// INIT
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  /// HANDLE NOTIFY RECEIVE
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.id != null) {
      /// CANCEL NOTIFY
      flutterLocalNotificationsPlugin.cancel(notificationResponse.id!);

      /// UPDATE STATUS
      instance
          .get<NotifyTaskLocalRepo>()
          .completeNotifyTask(notificationResponse.id!);
    }
  }

  displayNotification({required TaskNotify task}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        sound: UriAndroidNotificationSound("sound"),
        playSound: true,
        importance: Importance.max,
        priority: Priority.high);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      task.id!,
      task.title,
      task.note,
      platformChannelSpecifics,
      payload: "${task.title}" "${task.note}",
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
  }

  scheduledNotification(int hour, int minute, TaskNotify task) async {
    int year = int.parse(task.ringDay!.split("-")[2]);
    int day = int.parse(task.ringDay!.split("-")[1]);
    int month = int.parse(task.ringDay!.split("-")[0]);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title.toString(),
        task.note.toString(),
        _convertTime(year, month, day, hour, minute),
        const NotificationDetails(
            android: AndroidNotificationDetails('channel id 3', 'channel.name',
                sound: UriAndroidNotificationSound("sound"), playSound: true)),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "${task.title}" "${task.note}");
  }

  Future<void> doneNotify(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  scheduledRepeatNotification(
      int dayMore, int hour, int minute, TaskNotify task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title.toString(),
        task.note.toString(),
        _convertTimeForRepeat(dayMore, hour, minute),
        const NotificationDetails(
            android: AndroidNotificationDetails('channel id 2', 'channel.name',
                sound: RawResourceAndroidNotificationSound("sound"),
                playSound: true)),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "${task.title}" "${task.note}");
  }

  Future<void> configTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  tz.TZDateTime _convertTime(
      int year, int month, int day, int hour, int minute) {
    final tz.TZDateTime timeNow = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedule =
        tz.TZDateTime(tz.local, year, month, day, hour, minute);
    if (schedule.isBefore(timeNow)) {
      schedule = schedule.add(const Duration(days: 1));
    }
    return schedule;
  }

  tz.TZDateTime _convertTimeForRepeat(int day, int hour, int minute) {
    final tz.TZDateTime timeNow = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedule = tz.TZDateTime(
        tz.local, timeNow.year, timeNow.month, timeNow.day + day, hour, minute);
    if (schedule.isBefore(timeNow)) {
      schedule = schedule.add(const Duration(days: 1));
    }
    return schedule;
  }
}
