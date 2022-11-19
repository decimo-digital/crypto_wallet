import 'package:crypto_wallet/model/purchase/purchase.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PurchasesList extends StatefulWidget {
  const PurchasesList({super.key});

  @override
  State<PurchasesList> createState() => _PurchasesListState();
}

class _PurchasesListState extends State<PurchasesList> {
  void _getPurchases() => GetIt.instance.get<ApiConnection>().getPurchases();

  @override
  void initState() {
    super.initState();
    _getPurchases();
  }

  @override
  void reassemble() {
    super.reassemble();
    _getPurchases();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Token>>(
      stream: GetIt.instance.get<CacheService>().getTokensStream(),
      builder: (context, tokenSnap) {
        final tokens = tokenSnap.data ?? <Token>[];

        return StreamBuilder<List<Purchase>>(
          stream: GetIt.instance.get<CacheService>().getStreamedPurchases(),
          builder: (context, snap) {
            final purchases = snap.data ?? <Purchase>[];
            if (purchases.isEmpty) {
              return Center(
                child: Text(context.localizations.txtNoPurchasesYet),
              );
            }
            return CustomScrollView(
              slivers: purchases
                  .map((p) {
                    final tokenInfo =
                        tokens.firstWhere((element) => element.id == p.coinId);

                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tokenInfo.name),
                              Text(
                                NumberFormat.compactCurrency(symbol: '€')
                                    .format(p.earnings),
                                style: TextStyle(
                                  color: p.earnings > 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          p.transactions.map(
                            (t) {
                              final assetUsedInfo = t.assetUsed == null
                                  ? null
                                  : tokens
                                      .firstWhere((tk) => tk.id == t.assetUsed);
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    'Acquistato con: ${assetUsedInfo?.symbol ?? '€'}',
                                  ),
                                  isThreeLine: true,
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          NumberFormat.currency(
                                            customPattern:
                                                '${tokenInfo.symbol} ###.##',
                                          ).format(t.total),
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            t.date.toInt(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ];
                  })
                  .toList()
                  .expand((widget) => [...widget])
                  .toList(),
            );
          },
        );
      },
    );
  }
}
