// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    required String currency,
    @JsonKey(name: 'purchased_currency') required String purchasedCurrency,
    required num amount,
    required num change,
    @JsonKey(name: 'purchased_change') required num purchasedChange,
    required num fiat,
    required num date,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _Purchase.fromJson(json);
}
