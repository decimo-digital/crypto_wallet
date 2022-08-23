import 'package:crypto_wallet/main.dart';
import 'package:crypto_wallet/service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../model/token_data_market.dart';

class TokenList extends StatefulWidget {
  const TokenList({super.key});

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  List<Token> listToken = <Token>[];
  final service = DataService();

  @override
  void initState() {
    super.initState();
    getToken();
    print(listToken.length.toString());
  }

  void getToken() async {
    listToken = await service.fetchToken();
  }

  @override
  Widget build(BuildContext context) {
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var currentToken = listToken[index];
              return Card(
                child: ListTile(
                  title: Text(currentToken.name!),
                  subtitle: Text(currentToken.currentPrice.toString()),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(currentToken.image!),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {},
                  ),
                  onTap: () {
                    context.push(
                      context.namedLocation(
                        Routes.coinDetails.name,
                        params: {'coin': 'BTC'},
                      ),
                    );
                  },
                ),
              );
            },
            childCount: listToken.length,
          ),
        ),
      ],
    );
  }
}
