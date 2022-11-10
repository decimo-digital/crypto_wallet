import 'dart:convert';

import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class ApiConnection {
  final _baseUrl =
      'https://3207-47-53-15-21.eu.ngrok.io/cryptowallet-decimo/us-central1';

  final _client = Client();

  final _cacheService = GetIt.instance.get<CacheService>();

  Future<void> getTokens() async {
    final response = await _client.get(Uri.parse('$_baseUrl/getCoins'));

    final tokens = response.statusCode != 200
        ? <Token>[]
        : (jsonDecode(response.body) as List)
            .map((e) => Token.fromJson(e))
            .toList();
    _cacheService.storeTokens(tokens);
  }
}
