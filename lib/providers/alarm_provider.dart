import 'package:bmi_app/database/alarm_hive.dart';
import 'package:bmi_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
}
