// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 0;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History()
      ..id = fields[0] as String?
      ..inspector = fields[1] as String?
      ..inspectionType = fields[2] as String?
      ..inspectionDate = fields[3] as DateTime
      ..anotations = fields[4] as int?
      ..archive = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.inspector)
      ..writeByte(2)
      ..write(obj.inspectionType)
      ..writeByte(3)
      ..write(obj.inspectionDate)
      ..writeByte(4)
      ..write(obj.anotations)
      ..writeByte(5)
      ..write(obj.archive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
