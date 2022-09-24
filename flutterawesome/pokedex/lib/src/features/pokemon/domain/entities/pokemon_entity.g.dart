// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonEntityHiveAdapter extends TypeAdapter<PokemonEntity> {
  @override
  final int typeId = 1;

  @override
  PokemonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      types: (fields[3] as List).cast<dynamic>(),
      height: fields[4] as int,
      weight: fields[5] as int,
      baseStats: fields[6] as BaseStats,
      isFavourite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.types)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.baseStats)
      ..writeByte(7)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonEntityHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
