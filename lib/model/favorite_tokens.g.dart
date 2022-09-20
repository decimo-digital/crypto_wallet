// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tokens.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteTokensAdapter extends TypeAdapter<FavoriteTokens> {
  @override
  final int typeId = 0;

  @override
  FavoriteTokens read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteTokens(
      favTokens: (fields[0] as List).cast<Token>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteTokens obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favTokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteTokensAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
