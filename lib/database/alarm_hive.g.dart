// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmHiveAdapter extends TypeAdapter<AlarmHive> {
  @override
  final int typeId = 1;

  @override
  AlarmHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmHive(
      title: fields[0] as String?,
      alarmDateTime: fields[1] as DateTime?,
      isActive: fields[2] == null ? true : fields[2] as bool?,
      isRepeat: fields[3] as bool?,
      gradientColorIndex: fields[4] == null ? 0 : fields[4] as int?,
      key: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.alarmDateTime)
      ..writeByte(2)
      ..write(obj.isActive)
      ..writeByte(3)
      ..write(obj.isRepeat)
      ..writeByte(4)
      ..write(obj.gradientColorIndex)
      ..writeByte(5)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
