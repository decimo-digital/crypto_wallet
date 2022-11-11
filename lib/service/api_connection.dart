import 'dart:convert';

import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class ApiConnection {
  final _host = 'https://b00c-47-53-15-21.eu.ngrok.io';
  late final _baseUrl = '$_host/cryptowallet-decimo/us-central1';

  final _client = Client();

  final _cacheService = GetIt.instance.get<CacheService>();

  Future<void> getTokens() async {
    final user = FirebaseAuth.instance.currentUser;
    assert(user != null);
    final response = await _client.get(
      Uri.parse('$_baseUrl/getCoins?userId=${user!.uid}'),
    );

    final tokens = response.statusCode != 200
        ? <Token>[]
        : (jsonDecode(response.body) as List)
            .map((e) => Token.fromJson(e))
            .toList();
    debugPrint(
      'Got ${tokens.where((t) => t.isFavorite ?? false).length} favorites',
    );
    _cacheService.storeTokens(tokens);
  }

  Future<void> setFavorite(String tokenId) async {
    final user = FirebaseAuth.instance.currentUser;
    assert(user != null);

    final response = await _client.post(
      Uri.parse('$_baseUrl/setUserFavorite'),
      body: {
        'userID': user!.uid,
        'tokenId': tokenId,
      },
    );

    if (response.statusCode == 200) {
      GetIt.instance
          .get<CacheService>()
          .updateFavoriteToken(tokenId, newFavoriteValue: true);
    }
  }

  Future<void> removeFavorite(String tokenId) async {
    final user = FirebaseAuth.instance.currentUser;
    assert(user != null);

    final response = await _client.delete(
      Uri.parse('$_baseUrl/deleteUserFavorite'),
      body: {
        'userID': user!.uid,
        'tokenId': tokenId,
      },
    );

    if (response.statusCode == 200) {
      GetIt.instance
          .get<CacheService>()
          .updateFavoriteToken(tokenId, newFavoriteValue: false);
    }
  }
}
