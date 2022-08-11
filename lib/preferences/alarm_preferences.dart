import 'dart:convert';

import 'package:bmi_app/models/alarm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmPreferences {
  static String alarm = 'alarm';

  Future<SharedPreferences> _sharedPref() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  Future _saveString(key, data) async {
    final pref = await _sharedPref();
    await pref.setString(key, data);
  }

  Future setAlarm(Alarm alarm) async {
    /// ubah data dari Map ke String agar bisa disave sharedpreference
    final json = alarm.toMap();

    final data = jsonEncode(json);

    await _saveString(alarm, data);
  }

  Future _getString(key) async {
    final pref = await _sharedPref();
    return pref.getString(key);
  }

  Future getAlarm(key) async {
    final data = await _getString(key);

    /// ubah ke json agar nanti saat pemanggilan data menggunakan Modelnya langsung yaitu Alarm
    final toJson = jsonDecode(data);

    final dataModel = Alarm.fromMap(toJson);

    return dataModel;
  }
}
