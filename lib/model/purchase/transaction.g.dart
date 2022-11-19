// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      total: json['total'] as num,
      changeAtPurchaseTime: json['change_at_purch_time'] as num,
      date: json['date'] as num,
      assetUsed: json['asset_used'] as String?,
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'total': instance.total,
      'change_at_purch_time': instance.changeAtPurchaseTime,
      'date': instance.date,
      'asset_used': instance.assetUsed,
    };
