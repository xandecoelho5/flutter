// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseStatsAdapter extends TypeAdapter<BaseStats> {
  @override
  final int typeId = 2;

  @override
  BaseStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseStats(
      hp: fields[0] as Hp,
      attack: fields[1] as Attack,
      defense: fields[2] as Defense,
      specialAttack: fields[3] as SpecialAttack,
      specialDefense: fields[4] as SpecialDefense,
      speed: fields[5] as Speed,
    );
  }

  @override
  void write(BinaryWriter writer, BaseStats obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.hp)
      ..writeByte(1)
      ..write(obj.attack)
      ..writeByte(2)
      ..write(obj.defense)
      ..writeByte(3)
      ..write(obj.specialAttack)
      ..writeByte(4)
      ..write(obj.specialDefense)
      ..writeByte(5)
      ..write(obj.speed)
      ..writeByte(6)
      ..write(obj.averagePower);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HpAdapter extends TypeAdapter<Hp> {
  @override
  final int typeId = 3;

  @override
  Hp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hp(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Hp obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HpAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AttackAdapter extends TypeAdapter<Attack> {
  @override
  final int typeId = 4;

  @override
  Attack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attack(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Attack obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DefenseAdapter extends TypeAdapter<Defense> {
  @override
  final int typeId = 5;

  @override
  Defense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Defense(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Defense obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialAttackAdapter extends TypeAdapter<SpecialAttack> {
  @override
  final int typeId = 6;

  @override
  SpecialAttack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpecialAttack(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SpecialAttack obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialAttackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialDefenseAdapter extends TypeAdapter<SpecialDefense> {
  @override
  final int typeId = 7;

  @override
  SpecialDefense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpecialDefense(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SpecialDefense obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialDefenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpeedAdapter extends TypeAdapter<Speed> {
  @override
  final int typeId = 8;

  @override
  Speed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Speed(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Speed obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AveragePowerAdapter extends TypeAdapter<AveragePower> {
  @override
  final int typeId = 9;

  @override
  AveragePower read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AveragePower(
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AveragePower obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.maxValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AveragePowerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
