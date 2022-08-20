import 'package:hive_flutter/adapters.dart';

class HiveInstance {
  final String _box = 'alarm';

  initHive() async {
    await Hive.initFlutter();
    await Hive.openBox(_box);
  }
}
