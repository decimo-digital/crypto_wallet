import 'dart:convert';

import 'package:crypto_wallet/model/purchase/purchase.dart';
import 'package:crypto_wallet/model/purchase/transaction.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/model/token_history.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class ApiConnection {
  @visibleForTesting
  ApiConnection.mocked(Client mockClient, String userId)
      : _client = mockClient,
        _userId = userId;

  ApiConnection();

  final _host = 'https://7388-47-53-15-21.eu.ngrok.io';
  late final _baseUrl = '$_host/cryptowallet-decimo/us-central1';

  late String? _userId;

  String? get userId => _userId;

  // ignore: prefer_final_fields
  var _client = Client();

  final _cacheService = GetIt.instance.get<CacheService>();

  Future<void> getTokens() async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    debugPrint('Requesting coins');

    final response = await _client
        .get(Uri.parse('$_baseUrl/getCoins?userId=$_userId'))
        .onError((error, stackTrace) {
      debugPrint('Failed to get coins: $error');
      return Response(jsonEncode({}), 500);
    });

    final tokens = response.statusCode != 200
        ? <Token>[]
        : (jsonDecode(response.body) as List)
            .map((e) => Token.fromJson(e))
            .toList();
    debugPrint(
      'Got ${tokens.where((t) => t.isFavorite ?? false).length} favorites',
    );

    _cacheService.storeTokens([
      ...tokens.where((t) => t.isFavorite ?? false).toList()
        ..sort((a, b) => a.name.compareTo(b.name)),
      ...tokens.where((t) => !(t.isFavorite ?? false)).toList()
        ..sort((a, b) => a.name.compareTo(b.name)),
    ]);
  }

  Future<bool> createUser(String userId) async {
    debugPrint('Creating anonymous user');

    final response = await _client.post(
      Uri.parse('$_baseUrl/createUser'),
      body: jsonEncode({'userId': userId}),
      headers: {'Content-Type': 'application/json'},
    ).onError((error, stackTrace) {
      debugPrint('Failed to create user: $error');
      return Response(jsonEncode({}), 500);
    });

    if (response.statusCode == 200) {
      debugPrint('Successfully created user $userId');
      _userId = userId;
      return true;
    } else {
      debugPrint(
        'Failed to create user: ${(jsonDecode(response.body) as Map)['message']}',
      );
      return false;
    }
  }

  Future<bool> validateUid(String userId) async {
    debugPrint('Validating anonymous uid');

    final response = await _client.post(
      Uri.parse('$_baseUrl/validateUid'),
      body: jsonEncode({'userId': userId}),
      headers: {'Content-Type': 'application/json'},
    ).onError((error, stackTrace) {
      debugPrint('Failed to create user: $error');
      return Response(jsonEncode({}), 500);
    });

    if (response.statusCode == 200) {
      debugPrint('User $userId exists');
      _userId = userId;
      return true;
    } else {
      debugPrint(
        'Failed to validate uid: ${(jsonDecode(response.body) as Map)['message']}',
      );
      return false;
    }
  }

  Future<void> getPurchases() async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    final response = await _client
        .get(Uri.parse('$_baseUrl/getPurchases?userID=$_userId'))
        .onError((error, stackTrace) {
      debugPrint('Failed to get purchases: $error');
      debugPrintStack(stackTrace: stackTrace);
      return Response(jsonEncode({}), 500);
    });

    debugPrint('Get purchases returned: ${response.statusCode}');

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      if (map.isNotEmpty) {
        final purchases = map['purchases'] as Map<String, dynamic>;
        final earnings = map['earnings'] as Map<String, dynamic>;

        final purchasesStored = <Purchase>[];
        for (var element in purchases.entries) {
          final coinId = element.key;

          purchasesStored.add(
            Purchase(
              coinId: coinId,
              transactions: (element.value as List)
                  .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
                  .toList(),
              earnings: earnings[coinId],
            ),
          );
        }

        GetIt.instance.get<CacheService>().storePurchases(purchasesStored);
      }
    }

    debugPrint('Received response ${response.statusCode}');
  }

  Future<bool> purchaseToken({
    required String purchasedCoin,
    required String purchasingCoin,
    required num amount,
  }) async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    final response = await _client.post(
      Uri.parse('$_baseUrl/purchaseCoin'),
      body: jsonEncode({
        'userID': _userId,
        'purchasedCoin': purchasedCoin,
        'purchasingCoin': purchasingCoin,
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    ).onError((error, stackTrace) {
      debugPrint('Failed to purchase coin: $error');
      debugPrintStack(stackTrace: stackTrace);
      return Response(jsonEncode({}), 500);
    });
    debugPrint('Received response ${response.statusCode}');
    return response.statusCode == 200;
  }

  Future<num> convertCurrency({
    required String sourceCoinId,
    required String targetCoinId,
    required num sourceCoinAmount,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/convertCurrency'),
      body: jsonEncode({
        'sourceCurrencyId': sourceCoinId,
        'sourceCurrencyAmount': sourceCoinAmount,
        'targetCurrencyId': targetCoinId.toString(),
      }),
      headers: {'Content-Type': 'application/json'},
    ).onError((error, stackTrace) {
      debugPrint('Failed to convert currency: $error');
      debugPrintStack(stackTrace: stackTrace);
      return Response(jsonEncode({}), 500);
    });

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as Map<String, dynamic>)['amount'];
    }
    return 0;
  }

  Future<void> getBalances() async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    debugPrint('Requesting balances');

    final response = await _client
        .get(Uri.parse('$_baseUrl/getBalances?userID=$_userId'))
        .onError((error, stackTrace) {
      debugPrint('Failed to get user balances: $error');
      return Response(jsonEncode({}), 500);
    });

    if (response.statusCode != 200) return;
    debugPrint('Received balances: ${jsonDecode(response.body)}');
    GetIt.instance.get<CacheService>().storeBalances(
          (jsonDecode(response.body) as Map<String, dynamic>)['balances'],
        );
  }

  Future<void> setFavorite(String tokenId) async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    final response = await _client.post(
      Uri.parse('$_baseUrl/setUserFavorite'),
      body: {
        'userID': _userId,
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
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    final response = await _client.delete(
      Uri.parse('$_baseUrl/deleteUserFavorite'),
      body: {
        'userID': _userId,
        'tokenId': tokenId,
      },
    );

    if (response.statusCode == 200) {
      GetIt.instance
          .get<CacheService>()
          .updateFavoriteToken(tokenId, newFavoriteValue: false);
    }
  }

  Future<TokenHistory?> getHistory({
    required String tokenId,
    required DateTime from,
    DateTime? to,
  }) async {
    if (_userId == null) {
      final user = FirebaseAuth.instance.currentUser;
      assert(user != null);
    }

    final realTo = to ?? DateTime.now();
    final uri = Uri.parse(
      '$_baseUrl/getCoinHistory?tokenId=$tokenId&from=${from.millisecondsSinceEpoch ~/ 1000}&to=${realTo.millisecondsSinceEpoch ~/ 1000}&userID=$_userId',
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      return null;
    }

    return TokenHistory.fromJson(jsonDecode(response.body));
  }
}
