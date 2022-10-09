import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final isFavorite = ValueNotifier(false);
  final service = DataService();
  var tokensBox;

  @override
  void initState() {
    getToken();
    super.initState();
    debugPrint('Tokens loaded');
  }

  Future<void> getToken() async {
    final tokens = await service.fetchToken();
    debugPrint('Loaded ${tokens.length} tokens from api');

    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      _tokens.value = tokens;
      _tokens.value.map((e) => Hive.box<Token>('tokensBox').add(e));
      debugPrint(Hive.box<Token>('tokensBox').values.toString());
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _tokens.value = tokens;
        _tokens.value.map((e) => Hive.box<Token>('tokensBox').add(e));
        debugPrint(Hive.box<Token>('tokensBox').values.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(Hive.box<Token>('tokensBox').values.toString());
    debugPrint(_tokens.value.length.toString());

    return RefreshIndicator(
      onRefresh: () async {
        await getToken();
      },
      child: ValueListenableBuilder<Box<Token>>(
        valueListenable: Hive.box<Token>('tokensBox').listenable(),
        builder: (context, box, _) {
          final myTokensList = box.values.toList();
          final myFavTokens = box.values
              .where((element) => element.isFavorite == true)
              .toList();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Favorites',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Flexible(
                        child: myFavTokens.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  final favToken = myFavTokens[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Chip(
                                      backgroundColor: const Color(0xFFE4E4E4),
                                      avatar: const CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Icon(FontAwesomeIcons.bitcoin),
                                      ),
                                      label: Text(
                                        favToken.currentPrice.toString(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      onDeleted: () {},
                                      deleteIconColor: Colors.black,
                                    ),
                                  );
                                }),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final currentToken = myTokensList[index];
                    return Card(
                      child: ListTile(
                        title: Text(currentToken.name),
                        subtitle: Text(currentToken.currentPrice.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.network(currentToken.image),
                        ),
                        trailing: ValueListenableBuilder(
                          valueListenable:
                              isFavorite, // qui si prendera' il valore della hive box dei preferiti del token corrente
                          builder: (context, value, _) {
                            return IconButton(
                              icon: isFavorite.value
                                  ? const Icon(Icons.star)
                                  : const Icon(
                                      Icons.star_outline,
                                      color: Colors.black,
                                    ),
                              color: isFavorite.value
                                  ? Colors.orange
                                  : Colors.white,
                              onPressed: () {
                                isFavorite.value = !isFavorite.value;
                              },
                            );
                          },
                        ),
                        onTap: () {
                          context.push(
                            context.namedLocation(
                              Routes.coinDetails.name,
                              params: {
                                'coin': currentToken.id.toString(),
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: myTokensList.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
