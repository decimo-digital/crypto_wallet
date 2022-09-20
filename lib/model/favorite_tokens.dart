import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:hive/hive.dart';
part 'favorite_tokens.g.dart';

@HiveType(typeId: 0)
class FavoriteTokens {
  @HiveField(0)
  final List<Token> favTokens;

  FavoriteTokens({
    required this.favTokens,
  });
}
