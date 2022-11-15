import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:crypto_wallet/widgets/token_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/token_data_market.dart';

class TokenList extends StatefulWidget {
  const TokenList({super.key});

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList>
    with AutomaticKeepAliveClientMixin {
  final _tokens = ValueNotifier<List<Token>>([]);
  final _cacheService = GetIt.instance.get<CacheService>();
  final _connection = GetIt.instance.get<ApiConnection>();
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _connection.getTokens().then((_) => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _tokens.value.map((element) => Hive.box<Token>('tokensBox').add(element));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<Token>>(
          stream: _cacheService.getTokensStream(),
          builder: (context, snap) {
            final myFavTokens = (snap.data ?? <Token>[])
                .where((t) => t.isFavorite ?? false)
                .toList();

            return SizedBox(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.localizations.lblFavourites,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Flexible(
                    child: myFavTokens.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: myFavTokens.length,
                            itemBuilder: ((context, index) {
                              final favToken = myFavTokens[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(
                                  backgroundColor: const Color(0xFFE4E4E4),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(favToken.image),
                                    ),
                                  ),
                                  label: Text(
                                    favToken.currentPrice.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  onDeleted: () {
                                    _cacheService.updateFavoriteToken(
                                      favToken.id,
                                      newFavoriteValue: false,
                                    );
                                  },
                                  deleteIconColor: Colors.black,
                                ),
                              );
                            }),
                          )
                        : SizedBox(
                            child: Text(
                              context.localizations.txtNoFavouritesYet,
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => await _connection.getTokens(),
            child: StreamBuilder<List<Token>>(
              stream: _cacheService.getTokensStream(),
              builder: (context, snap) {
                final myTokensList = snap.data ?? <Token>[];
                if (_isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final currentToken = myTokensList[index];
                    return TokenCard(
                      token: currentToken,
                      onTap: () async {
                        context.push(
                          context.namedLocation(
                            Routes.coinDetails.name,
                            params: {
                              'coin': currentToken.id.toString(),
                              'currentPrice':
                                  currentToken.currentPrice.toString(),
                              'price24h': currentToken.price24h.toString(),
                            },
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: currentToken.isFavorite == true
                            ? const Icon(Icons.star)
                            : const Icon(
                                Icons.star_outline,
                                color: Colors.black,
                              ),
                        color: currentToken.isFavorite == true
                            ? Colors.orange
                            : Colors.white,
                        onPressed: () async {
                          debugPrint('${currentToken.isFavorite}');
                          final isFav = currentToken.isFavorite == null
                              ? true
                              : !currentToken.isFavorite!;

                          final conn = GetIt.instance.get<ApiConnection>();

                          if (isFav) {
                            await conn.setFavorite(currentToken.id);
                          } else {
                            await conn.removeFavorite(currentToken.id);
                          }
                        },
                      ),
                    );
                  },
                  itemCount: myTokensList.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
