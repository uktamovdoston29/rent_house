// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseModelAdapter extends TypeAdapter<HouseModel> {
  @override
  final int typeId = 0;

  @override
  HouseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HouseModel(
      id: fields[1] as String,
      image: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      locationName: fields[5] as String,
      name: fields[6] as String,
      price: fields[7] as int,
      rating: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HouseModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.locationName)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HouseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
