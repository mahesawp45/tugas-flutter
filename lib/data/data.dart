import 'package:bmi_app/models/alarm_model.dart';

List<Alarm> alarms = [
  Alarm(
    alarmDateTime: DateTime.now().add(
      const Duration(hours: 1),
    ),
    description: 'Makan Pagi',
  ),
  Alarm(
    alarmDateTime: DateTime.now().add(
      const Duration(hours: 1),
    ),
    description: 'Makan Siang',
  ),
];
