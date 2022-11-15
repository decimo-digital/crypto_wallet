// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokenHistory _$$_TokenHistoryFromJson(Map<String, dynamic> json) =>
    _$_TokenHistory(
      prices: (json['prices'] as List<dynamic>?)
              ?.map((e) => TokenHistoryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TokenHistoryToJson(_$_TokenHistory instance) =>
    <String, dynamic>{
      'prices': instance.prices,
    };
