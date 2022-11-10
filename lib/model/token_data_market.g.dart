// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_data_market.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Token _$$_TokenFromJson(Map<String, dynamic> json) => _$_Token(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      image: json['image'] as String,
      currentPrice: json['current_price'] as num,
      isFavorite: json['isFavorite'] as bool?,
      price24h: json['price_change_24h'] as num?,
    );

Map<String, dynamic> _$$_TokenToJson(_$_Token instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'isFavorite': instance.isFavorite,
      'price_change_24h': instance.price24h,
    };
