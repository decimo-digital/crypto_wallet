import 'package:crypto_wallet/model/token_history_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_history.freezed.dart';
part 'token_history.g.dart';

@freezed
class TokenHistory with _$TokenHistory {
  const factory TokenHistory({
    @Default([]) List<TokenHistoryItem> prices,
    @JsonKey(name: 'since_last_purchase') num? sinceLastPurchase,
  }) = _TokenHistory;

  factory TokenHistory.fromJson(Map<String, dynamic> json) =>
      _TokenHistory.fromJson(json);
}
