// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'token_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TokenHistoryItem _$TokenHistoryItemFromJson(Map<String, dynamic> json) {
  return _TokenHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$TokenHistoryItem {
  num get day => throw _privateConstructorUsedError;
  num get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenHistoryItemCopyWith<TokenHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenHistoryItemCopyWith<$Res> {
  factory $TokenHistoryItemCopyWith(
          TokenHistoryItem value, $Res Function(TokenHistoryItem) then) =
      _$TokenHistoryItemCopyWithImpl<$Res, TokenHistoryItem>;
  @useResult
  $Res call({num day, num value});
}

/// @nodoc
class _$TokenHistoryItemCopyWithImpl<$Res, $Val extends TokenHistoryItem>
    implements $TokenHistoryItemCopyWith<$Res> {
  _$TokenHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as num,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenHistoryItemCopyWith<$Res>
    implements $TokenHistoryItemCopyWith<$Res> {
  factory _$$_TokenHistoryItemCopyWith(
          _$_TokenHistoryItem value, $Res Function(_$_TokenHistoryItem) then) =
      __$$_TokenHistoryItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num day, num value});
}

/// @nodoc
class __$$_TokenHistoryItemCopyWithImpl<$Res>
    extends _$TokenHistoryItemCopyWithImpl<$Res, _$_TokenHistoryItem>
    implements _$$_TokenHistoryItemCopyWith<$Res> {
  __$$_TokenHistoryItemCopyWithImpl(
      _$_TokenHistoryItem _value, $Res Function(_$_TokenHistoryItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? value = null,
  }) {
    return _then(_$_TokenHistoryItem(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as num,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenHistoryItem implements _TokenHistoryItem {
  const _$_TokenHistoryItem({required this.day, required this.value});

  factory _$_TokenHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$$_TokenHistoryItemFromJson(json);

  @override
  final num day;
  @override
  final num value;

  @override
  String toString() {
    return 'TokenHistoryItem(day: $day, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenHistoryItem &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, day, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenHistoryItemCopyWith<_$_TokenHistoryItem> get copyWith =>
      __$$_TokenHistoryItemCopyWithImpl<_$_TokenHistoryItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenHistoryItemToJson(
      this,
    );
  }
}

abstract class _TokenHistoryItem implements TokenHistoryItem {
  const factory _TokenHistoryItem(
      {required final num day, required final num value}) = _$_TokenHistoryItem;

  factory _TokenHistoryItem.fromJson(Map<String, dynamic> json) =
      _$_TokenHistoryItem.fromJson;

  @override
  num get day;
  @override
  num get value;
  @override
  @JsonKey(ignore: true)
  _$$_TokenHistoryItemCopyWith<_$_TokenHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}
