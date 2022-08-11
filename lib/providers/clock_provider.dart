import 'dart:async';

import 'package:flutter/cupertino.dart';

class ClockProvider extends ChangeNotifier {
  /// Untuk update UI per 1 detik
  upDateClock() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }
}
