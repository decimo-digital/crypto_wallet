// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  num get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'change_at_purch_time')
  num get changeAtPurchaseTime => throw _privateConstructorUsedError;
  num get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'asset_used')
  String? get assetUsed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {num total,
      @JsonKey(name: 'change_at_purch_time') num changeAtPurchaseTime,
      num date,
      @JsonKey(name: 'asset_used') String? assetUsed});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? changeAtPurchaseTime = null,
    Object? date = null,
    Object? assetUsed = freezed,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      changeAtPurchaseTime: null == changeAtPurchaseTime
          ? _value.changeAtPurchaseTime
          : changeAtPurchaseTime // ignore: cast_nullable_to_non_nullable
              as num,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as num,
      assetUsed: freezed == assetUsed
          ? _value.assetUsed
          : assetUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$_TransactionCopyWith(
          _$_Transaction value, $Res Function(_$_Transaction) then) =
      __$$_TransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num total,
      @JsonKey(name: 'change_at_purch_time') num changeAtPurchaseTime,
      num date,
      @JsonKey(name: 'asset_used') String? assetUsed});
}

/// @nodoc
class __$$_TransactionCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$_Transaction>
    implements _$$_TransactionCopyWith<$Res> {
  __$$_TransactionCopyWithImpl(
      _$_Transaction _value, $Res Function(_$_Transaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? changeAtPurchaseTime = null,
    Object? date = null,
    Object? assetUsed = freezed,
  }) {
    return _then(_$_Transaction(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as num,
      changeAtPurchaseTime: null == changeAtPurchaseTime
          ? _value.changeAtPurchaseTime
          : changeAtPurchaseTime // ignore: cast_nullable_to_non_nullable
              as num,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as num,
      assetUsed: freezed == assetUsed
          ? _value.assetUsed
          : assetUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaction implements _Transaction {
  const _$_Transaction(
      {required this.total,
      @JsonKey(name: 'change_at_purch_time') required this.changeAtPurchaseTime,
      required this.date,
      @JsonKey(name: 'asset_used') this.assetUsed});

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

  @override
  final num total;
  @override
  @JsonKey(name: 'change_at_purch_time')
  final num changeAtPurchaseTime;
  @override
  final num date;
  @override
  @JsonKey(name: 'asset_used')
  final String? assetUsed;

  @override
  String toString() {
    return 'Transaction(total: $total, changeAtPurchaseTime: $changeAtPurchaseTime, date: $date, assetUsed: $assetUsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaction &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.changeAtPurchaseTime, changeAtPurchaseTime) ||
                other.changeAtPurchaseTime == changeAtPurchaseTime) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.assetUsed, assetUsed) ||
                other.assetUsed == assetUsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, total, changeAtPurchaseTime, date, assetUsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      __$$_TransactionCopyWithImpl<_$_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(
      this,
    );
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
      {required final num total,
      @JsonKey(name: 'change_at_purch_time')
          required final num changeAtPurchaseTime,
      required final num date,
      @JsonKey(name: 'asset_used')
          final String? assetUsed}) = _$_Transaction;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override
  num get total;
  @override
  @JsonKey(name: 'change_at_purch_time')
  num get changeAtPurchaseTime;
  @override
  num get date;
  @override
  @JsonKey(name: 'asset_used')
  String? get assetUsed;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
