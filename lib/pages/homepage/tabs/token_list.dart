import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../model/token_data_market.dart';

class TokenList extends StatefulWidget {
  const TokenList({super.key});

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList>
    with AutomaticKeepAliveClientMixin {
  final _tokens = ValueNotifier<List<Token>>([]);
  final service = DataService();

  @override
  void initState() {
    getToken();
    super.initState();
    debugPrint('Tokens loaded');
  }

  Future<void> getToken() async {
    final tokens = await service.fetchToken();
    debugPrint('Loaded ${tokens.length} tokens from api');
    //_tokens.value = [];
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      _tokens.value = tokens;
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _tokens.value = tokens;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getToken();
      },
      child: CustomScrollView(
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Chip(
                            backgroundColor: const Color(0xFFE4E4E4),
                            avatar: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(FontAwesomeIcons.bitcoin),
                            ),
                            label: const Text(
                              '€ 2500',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            onDeleted: () {},
                            deleteIconColor: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Chip(
                            backgroundColor: const Color(0xFFE4E4E4),
                            avatar: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(FontAwesomeIcons.ethereum),
                            ),
                            label: const Text(
                              '€ 190',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            onDeleted: () {},
                            deleteIconColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<List<Token>>(
            valueListenable: _tokens,
            builder: (context, listone, _) {
              debugPrint('rebuilding with ${listone.length} items');
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final currentToken = listone[index];
                    return Card(
                      child: ListTile(
                        title: Text(currentToken.name),
                        subtitle: Text(currentToken.currentPrice.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.network(currentToken.image),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.star),
                          onPressed: () {},
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
                  childCount: listone.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
