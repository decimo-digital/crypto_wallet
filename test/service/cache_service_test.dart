import 'package:crypto_wallet/model/purchase/purchase.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final service = CacheService();

  setUp(() async => await service.init('.'));

  tearDown(() async => service.deleteBox());

  test('Testa lo stream dei token', () {
    const token = Token(
      id: 'id',
      name: 'name',
      symbol: 'symbol',
      image: 'image',
      currentPrice: 2,
    );

    expect(
      service.getTokensStream(),
      emitsInOrder([
        [],
        [token],
      ]),
    );

    service.storeTokens([token]);
  });

  test('Testa lo stream degli acquisti', () {
    const purchase = Purchase(
      coinId: 'asd',
      earnings: 123,
    );

    expect(
      service.getStreamedPurchases(),
      emitsInOrder([
        [],
        [purchase],
      ]),
    );

    service.storePurchases([purchase]);
  });

  test('Testa lo stream dei balance', () {
    const balances = {
      'asijdoas': 123,
      'asdio': 123,
    };

    const b1 = {'asd': 123};

    expect(
      service.getStreamedBalances(),
      emitsInOrder([
        {},
        b1,
        balances,
      ]),
    );

    service.storeBalances(b1);
    service.storeBalances(balances);
  });
}
