import 'package:bmi_app/database/alarm_hive.dart';
import 'package:bmi_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmProvider extends ChangeNotifier {
  List<AlarmHive> alarms = [];

  Box? myalarm = Hive.box(alarmBox);

  // Get semua alarm dari DB
  void refreshAlarms() {
    final data = myalarm?.keys.map((key) {
      final value = myalarm?.get(key);

      return AlarmHive()
        ..stringID = value.stringID
        ..title = value.title
        ..alarmDateTime = value.alarmDateTime
        ..isActive = value.isActive
        ..isRepeat = value.isRepeat
        ..gradientColorIndex = value.gradientColorIndex;
    }).toList();

    alarms = data?.reversed.toList() ?? [];
    // notifyListeners();
  }

  // CREATE alarm
  createAlarm(AlarmHive newAlarm) async {
    await myalarm!.add(newAlarm);

    refreshAlarms();
    scheduleAlarm(
      newAlarm.alarmDateTime ?? DateTime.now(),
      newAlarm,
      isRepeating: newAlarm.isRepeat ?? true,
      isActive: newAlarm.isActive ?? true,
    );
    notifyListeners();
  }

  // SHOW 1 alarm
  Map<String, dynamic> readAlarm(key) {
    final alarm = myalarm?.get(key);
    return alarm;
  }

  // UPDATE alarm
  updateAlarm(AlarmHive item) async {
    // await myalarm?.put(itemKey, item);
    late AlarmHive data;
    myalarm?.keys.map((key) {
      var a = myalarm?.get(key);

      if (a.stringID == item.stringID) {
        data = a
          ..stringID = item.stringID
          ..title = item.title
          ..alarmDateTime = item.alarmDateTime
          ..isActive = item.isActive
          ..isRepeat = item.isRepeat
          ..gradientColorIndex = item.gradientColorIndex;

        data.save();
      }
    }).toList();

    scheduleAlarm(
      item.alarmDateTime ?? DateTime.now(),
      item,
      isRepeating: item.isRepeat ?? true,
      isActive: item.isActive ?? true,
    );
    notifyListeners();
  }

  // DELETE alarm
  deleteAlarm(AlarmHive e, BuildContext context) async {
    myalarm?.keys.map((key) {
      var a = myalarm?.get(key);
      if (a.stringID == e.stringID) a.delete();
    }).toList();

    refreshAlarms();
    notifyListeners();
    Navigator.pop(context);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'One Alarm has been deleted',
        ),
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmHive alarmHive,
      {required bool isRepeating, required bool isActive}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'ic_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (isRepeating && isActive) {
      // await flutterLocalNotificationsPlugin.show(
      //   alarmHive.key,
      //   alarmHive.title,
      //   'This Time to ${alarmHive.title}💙',
      //   NotificationDetails(
      //     android: androidPlatformChannelSpecifics,
      //     iOS: iOSPlatformChannelSpecifics,
      //   ),
      // );

      await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        alarmHive.title,
        'This Time to ${alarmHive.title}💙',
        Time(
          scheduledNotificationDateTime.hour,
          scheduledNotificationDateTime.minute,
          scheduledNotificationDateTime.second,
        ),
        platformChannelSpecifics,
      );
    } else if (isActive == false) {
      null;
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        alarmHive.title,
        alarmHive.title,
        tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
