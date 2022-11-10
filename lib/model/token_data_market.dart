// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'token_data_market.freezed.dart';
part 'token_data_market.g.dart';

@freezed
class Token with _$Token {
  const factory Token({
    required String id,
    required String name,
    required String symbol,
    required String image,
    @JsonKey(name: 'current_price') required num currentPrice,
    bool? isFavorite,
    @JsonKey(name: 'price_change_24h') num? price24h,
  }) = _Token;
  factory Token.fromJson(Map<String, dynamic> json) => _Token.fromJson(json);
}

class TokenAdapter implements TypeAdapter<Token> {
  TokenAdapter(this.typeId);

  @override
  final int typeId;

  @override
  Token read(BinaryReader reader) {
    return Token.fromJson(reader.readMap().cast());
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer.writeMap(obj.toJson());
  }
}
