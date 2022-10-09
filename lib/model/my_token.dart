class MyToken {
  MyToken({
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
}
