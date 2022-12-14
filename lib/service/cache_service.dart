import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:crypto_wallet/model/purchase/purchase.dart';
import 'package:crypto_wallet/model/purchase/transaction.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const _hiveBoxName = 'cryptowallet';

enum _Keys {
  tokens('token'),
  purchases('purchases'),
  balances('balances');

  const _Keys(this.keyName);

  final String keyName;
}

class CacheService {
  late Box<Object> _box;

  var _initializationCompleter = Completer();

  Future<void> init([String? path]) async {
    assert(!_initializationCompleter.isCompleted);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<Token>(TokenAdapter(1));
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter<Purchase>(PurchaseAdapter(2));
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter<Transaction>(TransactionAdapter(3));
    }
    _box = await Hive.openBox<Object>(_hiveBoxName, path: path)
        .onError((error, stackTrace) {
      debugPrint('Failed to open box: $error');
      debugPrintStack(stackTrace: stackTrace);
      exit(1);
    });

    _initializationCompleter.complete();
  }

  Future<void> deleteBox() async {
    await _box.deleteAll(_Keys.values.map((k) => k.keyName));
    _initializationCompleter = Completer();
    return;
  }

  Stream<List<Token>> getTokensStream() {
    assert(_initializationCompleter.isCompleted);
    return StreamGroup.merge<List<Token>>([
      _box
          .watch(key: _Keys.tokens.keyName)
          .map((e) => e.value)
          .cast<List<Token>>(),
      Stream.value(
        (_box.get(_Keys.tokens.keyName) as List?)?.cast<Token>() ?? [],
      ),
    ]);
  }

  Future<void> storeTokens(List<Token> tokens) {
    assert(_initializationCompleter.isCompleted);
    return _box.put(_Keys.tokens.keyName, tokens);
  }

  Future<void> storePurchases(List<Purchase> purchases) {
    assert(_initializationCompleter.isCompleted);
    return _box.put(_Keys.purchases.keyName, purchases);
  }

  Future<void> storeBalances(Map<String, dynamic> balances) {
    assert(_initializationCompleter.isCompleted);
    return _box.put(_Keys.balances.keyName, balances);
  }

  Stream<Map<String, dynamic>> getStreamedBalances() => StreamGroup.merge([
        Stream.value(
          (_box.get(_Keys.balances.keyName) as Map? ?? <dynamic, dynamic>{})
              .cast(),
        ),
        _box
            .watch(key: _Keys.balances.keyName)
            .map((e) => e.value as Map<String, dynamic>? ?? {})
      ]);

  Stream<List<Purchase>> getStreamedPurchases() => StreamGroup.merge([
        Stream.value(
          (_box.get(_Keys.purchases.keyName) as List? ?? []).cast(),
        ),
        _box
            .watch(key: _Keys.purchases.keyName)
            .map((e) => e.value as List<Purchase>? ?? [])
      ]);

  Future<void> updateFavoriteToken(
    String tokenId, {
    required bool newFavoriteValue,
  }) {
    assert(_initializationCompleter.isCompleted);
    final tokens = _box.get(_Keys.tokens.keyName) as List<Token>?;
    if (tokens?.isNotEmpty ?? false) {
      final newTokens = tokens!.map((t) {
        if (t.id != tokenId) return t.copyWith();
        return t.copyWith(isFavorite: newFavoriteValue);
      }).toList();
      return storeTokens(newTokens);
    }
    return Future.value();
  }
}
