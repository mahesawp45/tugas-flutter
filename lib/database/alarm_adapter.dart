import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class AlarmHive extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  DateTime? alarmDateTime;

  @HiveField(2, defaultValue: true)
  bool? isActive;

  @HiveField(3)
  bool? isRepeat;

  @HiveField(4, defaultValue: 0)
  int? gradientColorIndex;

  AlarmHive(
      {this.title,
      this.alarmDateTime,
      this.isActive,
      this.isRepeat,
      this.gradientColorIndex});
}
