import 'package:bmi_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class DarkModeProvider extends ChangeNotifier {
  final _darkMode = Hive.box(darkModeBox);
  final String _key = 'isDark';

  getDarkMode() {
    return _darkMode.get(_key);
  }

  setDarkMode(bool? isDark) {
    _darkMode.put(_key, isDark ?? true);
    notifyListeners();
  }
}
