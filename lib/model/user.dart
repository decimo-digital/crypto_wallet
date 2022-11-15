import 'package:crypto_wallet/model/token_data_market.dart';

class User {
  User({
    required this.id,
    required this.username,
    required this.proPic,
    required this.favoriteTokens,
  });
  int id;
  String username;
  String proPic;
  List<Token> favoriteTokens;
}
