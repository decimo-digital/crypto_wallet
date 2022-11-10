// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Purchase _$$_PurchaseFromJson(Map<String, dynamic> json) => _$_Purchase(
      currency: json['currency'] as String,
      purchasedCurrency: json['purchased_currency'] as String,
      amount: json['amount'] as num,
      change: json['change'] as num,
      purchasedChange: json['purchased_change'] as num,
      fiat: json['fiat'] as num,
      date: json['date'] as num,
    );

Map<String, dynamic> _$$_PurchaseToJson(_$_Purchase instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'purchased_currency': instance.purchasedCurrency,
      'amount': instance.amount,
      'change': instance.change,
      'purchased_change': instance.purchasedChange,
      'fiat': instance.fiat,
      'date': instance.date,
    };
