import 'package:bmi_app/models/alarm_model.dart';
import 'package:flutter/material.dart';

List<Alarm> alarms = [
  Alarm(
      alarmDateTime: DateTime.now().add(
        const Duration(hours: 1),
      ),
      description: 'Makan Pagi',
      gradients: [Colors.red, Colors.purple.shade300]),
  Alarm(
    alarmDateTime: DateTime.now().add(
      const Duration(hours: 1),
    ),
    description: 'Makan Siang',
    gradients: [Colors.blue, Colors.indigo.shade500],
  ),
  Alarm(
    alarmDateTime: DateTime.now().add(
      const Duration(hours: 1),
    ),
    description: 'Makan Siang',
    gradients: [Colors.amber, Colors.orange.shade500],
  ),
  Alarm(
    alarmDateTime: DateTime.now().add(
      const Duration(hours: 1),
    ),
    description: 'Makan Siang',
    gradients: [Colors.lightGreen, Colors.green.shade500],
  ),
];
