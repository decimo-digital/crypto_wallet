import 'package:hive/hive.dart';

part 'token_data_market.g.dart';

@HiveType(typeId: 1)
class Token {
  Token({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    this.isFavorite,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String symbol;

  @HiveField(3)
  String image;

  @HiveField(4)
  double currentPrice;

  @HiveField(5)
  bool? isFavorite;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        image: json['image'],
        currentPrice: json['current_price'].toDouble(),
      );
}
