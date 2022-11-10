import 'dart:async';
import 'dart:io';

import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const _hiveBoxName = 'cryptowallet';

enum _Keys {
  tokens('token');

  const _Keys(this.keyName);

  final String keyName;
}

class CacheService {
  late final Box<Object> _box;

  final _initializationCompleter = Completer();

  Future<void> init() async {
    assert(!_initializationCompleter.isCompleted);
    Hive.registerAdapter<Token>(TokenAdapter(1));
    _box =
        await Hive.openBox<Object>(_hiveBoxName).onError((error, stackTrace) {
      debugPrint('Failed to open box: $error');
      debugPrintStack(stackTrace: stackTrace);
      exit(1);
    });

    _initializationCompleter.complete();
  }

  Stream<List<Token>> getTokensStream() {
    assert(_initializationCompleter.isCompleted);
    return _box
        .watch(key: _Keys.tokens.keyName)
        .map((e) => e.value)
        .cast<List<Token>>();
  }

  Future<void> storeTokens(List<Token> tokens) {
    assert(_initializationCompleter.isCompleted);
    return _box.put(_Keys.tokens.keyName, tokens);
  }

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
