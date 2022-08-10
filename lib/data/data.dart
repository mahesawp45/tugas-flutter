import 'package:bmi_app/models/alarm_model.dart';

List<Alarm> alarms = [
  Alarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      title: 'Makan Pagi',
      gradientColorIndex: 0),
  Alarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Istirahat Ngantor',
      gradientColorIndex: 1),
  Alarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Nyemil Dikit',
      gradientColorIndex: 2),
  Alarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Makan pulker',
      gradientColorIndex: 3),
  Alarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Self Reward',
      gradientColorIndex: 4),
];
