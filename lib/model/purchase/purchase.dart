import 'package:crypto_wallet/model/purchase/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    required String coinId,
    @Default([]) List<Transaction> transactions,
    required num earnings,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _Purchase.fromJson(json);
}

class PurchaseAdapter implements TypeAdapter<Purchase> {
  PurchaseAdapter(this.typeId);

  @override
  final int typeId;

  @override
  Purchase read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    final transactions = (map['transactions'] as List).cast<Transaction>();

    return Purchase(
      coinId: map['coinId'],
      transactions: transactions,
      earnings: map['earnings'],
    );
  }

  @override
  void write(BinaryWriter writer, Purchase obj) {
    writer.writeMap(obj.toJson());
  }
}
