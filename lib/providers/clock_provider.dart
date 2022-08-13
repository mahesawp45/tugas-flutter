import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockProvider extends ChangeNotifier {
  String? formattedTime;
  String? formattedDay;
  String? timeZone;

  /// Untuk update UI per 1 detik
  upDateClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
    // notifyListeners();
  }

  @override
  void notifyListeners() {
    var now = DateTime.now();
    formattedTime = DateFormat('HH:mm').format(now);
    formattedDay = DateFormat('EEEE, d MMMM').format(now);
    timeZone = now.timeZoneOffset.toString().split('.').first;
    super.notifyListeners();
  }
}
