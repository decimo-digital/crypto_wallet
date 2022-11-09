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
    required this.isFavorite,
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

  Token copyWith({
    String? id,
    String? name,
    String? symbol,
    String? image,
    double? currentPrice,
    bool? isFavorite,
  }) {
    return Token(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        image: json['image'],
        currentPrice: (json['current_price'] as num).toDouble(),
        isFavorite: json['isFavorite'] ?? false,
      );
}
