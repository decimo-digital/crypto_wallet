import 'package:hive/hive.dart';

import 'my_token.dart';
import 'token_data_market.dart';
part 'favorite_tokens.g.dart';

@HiveType(typeId: 0)
class FavoriteTokens {
  @HiveField(0)
  final List<Token> favTokens;

  FavoriteTokens({
    required this.favTokens,
  });
}
