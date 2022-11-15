import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_history_item.freezed.dart';
part 'token_history_item.g.dart';

@freezed
class TokenHistoryItem with _$TokenHistoryItem {
  const factory TokenHistoryItem({
    required num day,
    required num value,
  }) = _TokenHistoryItem;
  factory TokenHistoryItem.fromJson(Map<String, dynamic> json) =>
      _TokenHistoryItem.fromJson(json);
}
