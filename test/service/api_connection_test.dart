import 'dart:convert';

import 'package:crypto_wallet/model/purchase/purchase.dart';
import 'package:crypto_wallet/model/purchase/transaction.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_connection_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  final mockClient = MockClient();

  late final ApiConnection mockConnection;

  setUpAll(() async {
    GetIt.instance.registerSingletonAsync<CacheService>(() async {
      final service = CacheService();
      await service.init('.');
      return service;
    });
    await GetIt.I.isReady<CacheService>();
    mockConnection = ApiConnection.mocked(mockClient, 'asd');
  });

  tearDownAll(() async {
    await GetIt.instance.get<CacheService>().deleteBox();
  });

  test('Testa il recupero dei token', () async {
    final cache = GetIt.I.get<CacheService>();

    expect(
      cache.getTokensStream(),
      emitsInOrder([
        [],
        [predicate<Token>((v) => v.id == 'asd')]
      ]),
    );

    when(mockClient.get(any)).thenAnswer(
      (realInvocation) async => Response(
        jsonEncode([
          const Token(
            id: 'asd',
            name: 'name',
            symbol: 'symbol',
            image: 'image',
            currentPrice: 453,
          ),
        ]),
        200,
      ),
    );

    mockConnection.getTokens();
  });

  test('Testa il recupero degli acquisti', () async {
    final cache = GetIt.I.get<CacheService>();

    expect(
      cache.getStreamedPurchases(),
      emitsInOrder([
        [],
        [predicate<Purchase>((v) => v.coinId == 'BTC' && v.earnings == 123)]
      ]),
    );

    when(mockClient.get(any)).thenAnswer(
      (realInvocation) async => Response(
        jsonEncode({
          'purchases': {
            'BTC': [
              Transaction(
                total: 123,
                changeAtPurchaseTime: 123,
                date: DateTime.now().millisecondsSinceEpoch,
              ),
            ]
          },
          'earnings': {
            'BTC': 123,
          },
        }),
        200,
      ),
    );

    mockConnection.getPurchases();
  });
}
