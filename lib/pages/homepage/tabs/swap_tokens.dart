import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/model/token_data_market.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/service/cache_service.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

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

  Timer? _convertCurrencyTimer;
  final _targetTokenController = TextEditingController();
  final _sourceTokenController = TextEditingController();

  void _registerDebounce(num amountToConvert) {
    _convertCurrencyTimer?.cancel();
    _convertCurrencyTimer = Timer(const Duration(milliseconds: 400), () async {
      _targetTokenController.text = 'loading...';
      final newAmount =
          await GetIt.instance.get<ApiConnection>().convertCurrency(
                sourceCoinId: _sourceToken.value!.id,
                targetCoinId: _targetToken.value!.id,
                sourceCoinAmount: amountToConvert,
              );
      _targetTokenController.text = newAmount.toString();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    _connection.getBalances();
  }

  @override
  void initState() {
    super.initState();
    _connection.getBalances();
    _targetToken.addListener(() {
      if (_sourceToken.value != null &&
          _sourceTokenController.text.isNotEmpty) {
        _registerDebounce(num.parse(_sourceTokenController.text));
      }
    });
    _sourceToken.addListener(() {
      if (_targetToken.value != null &&
          _sourceTokenController.text.isNotEmpty) {
        _registerDebounce(num.parse(_sourceTokenController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _cacheService.getStreamedBalances(),
      builder: (context, snap) {
        final balances = snap.data ?? {};

        return StreamBuilder<List<Token>>(
          stream: _cacheService.getTokensStream(),
          builder: (context, snap) {
            final tokens = snap.data ?? <Token>[];
            return Column(
              children: [
                ValueListenableBuilder<Token?>(
                  valueListenable: _sourceToken,
                  builder: (context, value, _) {
                    if (tokens.isNotEmpty) {
                      _sourceToken.value ??= tokens
                              .any((t) => balances.containsKey(t.id))
                          ? tokens.firstWhere((t) => balances.containsKey(t.id))
                          : null;
                    }

                    return TextField(
                      controller: _sourceTokenController,
                      inputFormatters: [
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                            text: newValue.text.replaceAll(',', '.'),
                          ),
                        )
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _registerDebounce(num.parse(value));
                        }
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      decoration: InputDecoration(
                        helperText:
                            value == null || !balances.containsKey(value.id)
                                ? null
                                : NumberFormat.currency(
                                    customPattern: '${value.symbol} ###.##',
                                  ).format(balances[value.id]),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final scrollController = ScrollController();

                                  final tokenChosen = await showDialog<Token>(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              'Pick a coin',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          Flexible(
                                            child: Scrollbar(
                                              controller: scrollController,
                                              child: GridView.extent(
                                                controller: scrollController,
                                                maxCrossAxisExtent: 150,
                                                shrinkWrap: true,
                                                children: tokens
                                                    .where(
                                                      (t) => balances
                                                          .containsKey(t.id),
                                                    )
                                                    .map(
                                                      (t) => GestureDetector(
                                                        onTap: () =>
                                                            Navigator.of(
                                                          context,
                                                        ).pop(t),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl: t.image,
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              t.id,
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  if (tokenChosen != null) {
                                    _sourceToken.value = tokenChosen;
                                  }
                                },
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 90,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (value != null) ...[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.network(
                                            value.image,
                                            height: 20,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            value.symbol,
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
                                        const Flexible(
                                          child: VerticalDivider(
                                            color: Colors.black,
                                            thickness: 4,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
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
                ValueListenableBuilder<Token?>(
                  valueListenable: _targetToken,
                  builder: (context, value, _) {
                    debugPrint(
                      'Getting balance of ${value?.id} from $balances',
                    );
                    if (tokens.isNotEmpty) {
                      _targetToken.value ??= tokens.first;
                    }

                    return TextField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      controller: _targetTokenController,
                      inputFormatters: [FilteringTextInputFormatter.allow('')],
                      decoration: InputDecoration(
                        helperText:
                            value == null || !balances.containsKey(value.id)
                                ? null
                                : NumberFormat.currency(
                                    customPattern: '${value.symbol} ###.##',
                                  ).format(balances[value.id]),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final scrollController = ScrollController();

                                  final tokenChosen = await showDialog<Token>(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              'Pick a coin',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          Flexible(
                                            child: Scrollbar(
                                              controller: scrollController,
                                              child: GridView.extent(
                                                controller: scrollController,
                                                maxCrossAxisExtent: 150,
                                                children: tokens
                                                    .where(
                                                      (t) =>
                                                          t.id !=
                                                          _sourceToken
                                                              .value?.id,
                                                    )
                                                    .map(
                                                      (t) => GestureDetector(
                                                        onTap: () =>
                                                            Navigator.of(
                                                          context,
                                                        ).pop(t),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl: t.image,
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              t.id,
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  if (tokenChosen != null) {
                                    _targetToken.value = tokenChosen;
                                  }
                                },
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 90,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (value != null) ...[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.network(
                                            value.image,
                                            height: 20,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            value.symbol,
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
                                        const VerticalDivider(
                                          color: Colors.black,
                                          thickness: 4,
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_sourceTokenController.text.isEmpty) {
                            return;
                          }

                          final purchased = await GetIt.instance
                              .get<ApiConnection>()
                              .purchaseToken(
                                purchasedCoin: _sourceToken.value!.id,
                                purchasingCoin: _targetToken.value!.id,
                                amount: num.parse(_sourceTokenController.text),
                              );

                          if (purchased) {
                            GetIt.instance.get<ApiConnection>().getBalances();
                            setState(() {});
                            if (mounted) {
                              final messenger = ScaffoldMessenger.of(context);
                              messenger.showMaterialBanner(
                                MaterialBanner(
                                  content: Text(
                                    'Successfully purchased ${NumberFormat.currency(
                                      customPattern:
                                          '${_targetToken.value!.symbol} ###.##',
                                    ).format(num.parse(_targetTokenController.text))}',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          messenger.clearMaterialBanners(),
                                      child: const Text('ok'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Text(context.localizations.swap),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
