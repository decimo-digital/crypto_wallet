import 'package:crypto_wallet/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class TokenList extends StatefulWidget {
  const TokenList({super.key});

  @override
  State<TokenList> createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
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
            (context, index) => Card(
              child: ListTile(
                title: const Text('bitcoin'),
                subtitle: const Text('€ 2500'),
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    FontAwesomeIcons.bitcoin,
                    size: 30,
                  ),
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
            ),
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
