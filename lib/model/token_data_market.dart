class Token {
  Token({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.isFavorite,
  });

  String id;
  String name;
  String symbol;
  String image;
  double currentPrice;
  bool isFavorite;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        id: json['id'],
        name: json['name'],
        symbol: json['symbol'],
        image: json['image'],
        currentPrice: json['current_price'].toDouble(),
        isFavorite: json['favorite'],
      );
}
