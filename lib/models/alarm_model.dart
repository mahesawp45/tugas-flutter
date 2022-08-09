import 'package:flutter/cupertino.dart';

class Alarm {
  DateTime? alarmDateTime;
  String? description;
  bool? isActive;
  List<Color>? gradients;

  Alarm({this.alarmDateTime, this.description, this.gradients});
}
