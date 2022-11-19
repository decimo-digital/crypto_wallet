import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required num total,
    @JsonKey(name: 'change_at_purch_time') required num changeAtPurchaseTime,
    required num date,
    @JsonKey(name: 'asset_used')  String? assetUsed,
  }) = _Transaction;
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _Transaction.fromJson(json);
}

class TransactionAdapter implements TypeAdapter<Transaction> {
  TransactionAdapter(this.typeId);

  @override
  final int typeId;

  @override
  Transaction read(BinaryReader reader) {
    return Transaction.fromJson(reader.readMap().cast());
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer.writeMap(obj.toJson());
  }
}
