import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../../service/api_connection.dart';
import '../../../service/cache_service.dart';

class SwapTokens extends StatefulWidget {
  const SwapTokens({super.key});

  @override
  State<SwapTokens> createState() => _SwapTokensState();
}

class _SwapTokensState extends State<SwapTokens> {
  final _sourceToken = ValueNotifier<Token?>(null);
  final _targetToken = ValueNotifier<Token?>(null);
  final _cacheService = GetIt.instance.get<CacheService>();
  final _connection = GetIt.instance.get<ApiConnection>();

  @override
  void reassemble() {
    super.reassemble();
    _connection.getBalances();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Token>>(
      stream: _cacheService.getTokensStream(),
      builder: (context, snap) {
        final tokens = snap.data ?? <Token>[];
        return Column(
          children: [
            ValueListenableBuilder<Token?>(
              valueListenable: _sourceToken,
              builder: (context, value, _) {
                return TextField(
                  decoration: InputDecoration(
                    helperText: '0.005 BTC',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButton<Token>(
                            items: tokens
                                .map(
                                  (t) => DropdownMenuItem<Token>(
                                    value: t,
                                    alignment: Alignment.center,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 90,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: Image.network(
                                              t.image,
                                              height: 20,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              t.id,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val != null) _sourceToken.value = val;
                            },
                            alignment: Alignment.center,
                            underline: Container(),
                            itemHeight: kMinInteractiveDimension,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            dropdownColor: Colors.white,
                            value: value,
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Icon(
                FontAwesomeIcons.arrowRightArrowLeft,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                helperText: '0.0005 BTC',
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ValueListenableBuilder<Token?>(
                        valueListenable: _targetToken,
                        builder: (context, value, _) => DropdownButton<Token>(
                          items: tokens
                              .map(
                                (t) => DropdownMenuItem<Token>(
                                  value: t,
                                  alignment: Alignment.center,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 90,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.network(
                                            t.image,
                                            height: 20,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            t.id,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) => _targetToken.value = val ?? value,
                          alignment: Alignment.center,
                          underline: Container(),
                          itemHeight: kMinInteractiveDimension,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          dropdownColor: Colors.white,
                          value: value,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(context.localizations.swap),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
