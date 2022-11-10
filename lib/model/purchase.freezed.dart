// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchased_currency')
  String get purchasedCurrency => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  num get change => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchased_change')
  num get purchasedChange => throw _privateConstructorUsedError;
  num get fiat => throw _privateConstructorUsedError;
  num get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call(
      {String currency,
      @JsonKey(name: 'purchased_currency') String purchasedCurrency,
      num amount,
      num change,
      @JsonKey(name: 'purchased_change') num purchasedChange,
      num fiat,
      num date});
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? purchasedCurrency = null,
    Object? amount = null,
    Object? change = null,
    Object? purchasedChange = null,
    Object? fiat = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      purchasedCurrency: null == purchasedCurrency
          ? _value.purchasedCurrency
          : purchasedCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as num,
      purchasedChange: null == purchasedChange
          ? _value.purchasedChange
          : purchasedChange // ignore: cast_nullable_to_non_nullable
              as num,
      fiat: null == fiat
          ? _value.fiat
          : fiat // ignore: cast_nullable_to_non_nullable
              as num,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PurchaseCopyWith<$Res> implements $PurchaseCopyWith<$Res> {
  factory _$$_PurchaseCopyWith(
          _$_Purchase value, $Res Function(_$_Purchase) then) =
      __$$_PurchaseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currency,
      @JsonKey(name: 'purchased_currency') String purchasedCurrency,
      num amount,
      num change,
      @JsonKey(name: 'purchased_change') num purchasedChange,
      num fiat,
      num date});
}

/// @nodoc
class __$$_PurchaseCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$_Purchase>
    implements _$$_PurchaseCopyWith<$Res> {
  __$$_PurchaseCopyWithImpl(
      _$_Purchase _value, $Res Function(_$_Purchase) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? purchasedCurrency = null,
    Object? amount = null,
    Object? change = null,
    Object? purchasedChange = null,
    Object? fiat = null,
    Object? date = null,
  }) {
    return _then(_$_Purchase(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      purchasedCurrency: null == purchasedCurrency
          ? _value.purchasedCurrency
          : purchasedCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as num,
      purchasedChange: null == purchasedChange
          ? _value.purchasedChange
          : purchasedChange // ignore: cast_nullable_to_non_nullable
              as num,
      fiat: null == fiat
          ? _value.fiat
          : fiat // ignore: cast_nullable_to_non_nullable
              as num,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Purchase implements _Purchase {
  const _$_Purchase(
      {required this.currency,
      @JsonKey(name: 'purchased_currency') required this.purchasedCurrency,
      required this.amount,
      required this.change,
      @JsonKey(name: 'purchased_change') required this.purchasedChange,
      required this.fiat,
      required this.date});

  factory _$_Purchase.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseFromJson(json);

  @override
  final String currency;
  @override
  @JsonKey(name: 'purchased_currency')
  final String purchasedCurrency;
  @override
  final num amount;
  @override
  final num change;
  @override
  @JsonKey(name: 'purchased_change')
  final num purchasedChange;
  @override
  final num fiat;
  @override
  final num date;

  @override
  String toString() {
    return 'Purchase(currency: $currency, purchasedCurrency: $purchasedCurrency, amount: $amount, change: $change, purchasedChange: $purchasedChange, fiat: $fiat, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Purchase &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.purchasedCurrency, purchasedCurrency) ||
                other.purchasedCurrency == purchasedCurrency) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.purchasedChange, purchasedChange) ||
                other.purchasedChange == purchasedChange) &&
            (identical(other.fiat, fiat) || other.fiat == fiat) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currency, purchasedCurrency,
      amount, change, purchasedChange, fiat, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseCopyWith<_$_Purchase> get copyWith =>
      __$$_PurchaseCopyWithImpl<_$_Purchase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseToJson(
      this,
    );
  }
}

abstract class _Purchase implements Purchase {
  const factory _Purchase(
      {required final String currency,
      @JsonKey(name: 'purchased_currency')
          required final String purchasedCurrency,
      required final num amount,
      required final num change,
      @JsonKey(name: 'purchased_change')
          required final num purchasedChange,
      required final num fiat,
      required final num date}) = _$_Purchase;

  factory _Purchase.fromJson(Map<String, dynamic> json) = _$_Purchase.fromJson;

  @override
  String get currency;
  @override
  @JsonKey(name: 'purchased_currency')
  String get purchasedCurrency;
  @override
  num get amount;
  @override
  num get change;
  @override
  @JsonKey(name: 'purchased_change')
  num get purchasedChange;
  @override
  num get fiat;
  @override
  num get date;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseCopyWith<_$_Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}
