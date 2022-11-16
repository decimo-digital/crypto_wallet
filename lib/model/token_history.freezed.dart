// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenHistory _$TokenHistoryFromJson(Map<String, dynamic> json) {
  return _TokenHistory.fromJson(json);
}

/// @nodoc
mixin _$TokenHistory {
  List<TokenHistoryItem> get prices => throw _privateConstructorUsedError;
  @JsonKey(name: 'since_last_purchase')
  num? get sinceLastPurchase => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenHistoryCopyWith<TokenHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenHistoryCopyWith<$Res> {
  factory $TokenHistoryCopyWith(
          TokenHistory value, $Res Function(TokenHistory) then) =
      _$TokenHistoryCopyWithImpl<$Res, TokenHistory>;
  @useResult
  $Res call(
      {List<TokenHistoryItem> prices,
      @JsonKey(name: 'since_last_purchase') num? sinceLastPurchase});
}

/// @nodoc
class _$TokenHistoryCopyWithImpl<$Res, $Val extends TokenHistory>
    implements $TokenHistoryCopyWith<$Res> {
  _$TokenHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = null,
    Object? sinceLastPurchase = freezed,
  }) {
    return _then(_value.copyWith(
      prices: null == prices
          ? _value.prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<TokenHistoryItem>,
      sinceLastPurchase: freezed == sinceLastPurchase
          ? _value.sinceLastPurchase
          : sinceLastPurchase // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenHistoryCopyWith<$Res>
    implements $TokenHistoryCopyWith<$Res> {
  factory _$$_TokenHistoryCopyWith(
          _$_TokenHistory value, $Res Function(_$_TokenHistory) then) =
      __$$_TokenHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TokenHistoryItem> prices,
      @JsonKey(name: 'since_last_purchase') num? sinceLastPurchase});
}

/// @nodoc
class __$$_TokenHistoryCopyWithImpl<$Res>
    extends _$TokenHistoryCopyWithImpl<$Res, _$_TokenHistory>
    implements _$$_TokenHistoryCopyWith<$Res> {
  __$$_TokenHistoryCopyWithImpl(
      _$_TokenHistory _value, $Res Function(_$_TokenHistory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prices = null,
    Object? sinceLastPurchase = freezed,
  }) {
    return _then(_$_TokenHistory(
      prices: null == prices
          ? _value._prices
          : prices // ignore: cast_nullable_to_non_nullable
              as List<TokenHistoryItem>,
      sinceLastPurchase: freezed == sinceLastPurchase
          ? _value.sinceLastPurchase
          : sinceLastPurchase // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenHistory implements _TokenHistory {
  const _$_TokenHistory(
      {final List<TokenHistoryItem> prices = const [],
      @JsonKey(name: 'since_last_purchase') this.sinceLastPurchase})
      : _prices = prices;

  factory _$_TokenHistory.fromJson(Map<String, dynamic> json) =>
      _$$_TokenHistoryFromJson(json);

  final List<TokenHistoryItem> _prices;
  @override
  @JsonKey()
  List<TokenHistoryItem> get prices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prices);
  }

  @override
  @JsonKey(name: 'since_last_purchase')
  final num? sinceLastPurchase;

  @override
  String toString() {
    return 'TokenHistory(prices: $prices, sinceLastPurchase: $sinceLastPurchase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenHistory &&
            const DeepCollectionEquality().equals(other._prices, _prices) &&
            (identical(other.sinceLastPurchase, sinceLastPurchase) ||
                other.sinceLastPurchase == sinceLastPurchase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_prices), sinceLastPurchase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenHistoryCopyWith<_$_TokenHistory> get copyWith =>
      __$$_TokenHistoryCopyWithImpl<_$_TokenHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenHistoryToJson(
      this,
    );
  }
}

abstract class _TokenHistory implements TokenHistory {
  const factory _TokenHistory(
          {final List<TokenHistoryItem> prices,
          @JsonKey(name: 'since_last_purchase') final num? sinceLastPurchase}) =
      _$_TokenHistory;

  factory _TokenHistory.fromJson(Map<String, dynamic> json) =
      _$_TokenHistory.fromJson;

  @override
  List<TokenHistoryItem> get prices;
  @override
  @JsonKey(name: 'since_last_purchase')
  num? get sinceLastPurchase;
  @override
  @JsonKey(ignore: true)
  _$$_TokenHistoryCopyWith<_$_TokenHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
