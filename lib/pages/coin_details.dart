import 'package:crypto_wallet/l10n/generated/app_localizations.dart';
import 'package:crypto_wallet/model/token_history.dart';
import 'package:crypto_wallet/service/api_connection.dart';
import 'package:crypto_wallet/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:timeago/timeago.dart' as timeago;

class CoinDetails extends StatefulWidget {
  const CoinDetails({
    required this.coinId,
    required this.currentPrice,
    required this.price24h,
    super.key,
  });

  final String coinId;
  final String currentPrice;
  final String price24h;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  late DateTime _dateFrom;
  late DateTime _dateTo;
  late double _frequency;
  late double _variance;

  // ------
  /// Viene usato solo come hook per ricaricare la pagina con i nuovi
  /// [_dateFrom] e [_dateTo]
  final _lastHours = ValueNotifier<int?>(null);
  final _prices = ValueNotifier<TokenHistory?>(null);

  void _getHistory() {
    GetIt.instance
        .get<ApiConnection>()
        .getHistory(
          tokenId: widget.coinId,
          from: _dateFrom,
          to: _dateTo,
        )
        .then((val) {
      debugPrint('Received ${val?.prices.length} prices');
      debugPrint('Last purchase: ${val?.sinceLastPurchase}');
      final dates = val?.prices
          .map((d) => DateTime.fromMillisecondsSinceEpoch(d.day.toInt()))
          .toList()
        ?..sort();
      if (dates == null) return;

      _dateFrom = dates.first;
      _dateTo = dates.last;
      _frequency =
          (_dateTo.millisecondsSinceEpoch - _dateFrom.millisecondsSinceEpoch) /
              5.0;
      _variance = (val!.prices.last.value - val.prices.first.value).toDouble();
      _prices.value = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _dateTo = DateTime.now();
    _dateFrom = _dateTo.subtract(const Duration(days: 1));
    _lastHours.addListener(_getHistory);
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.coinId)),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ValueListenableBuilder<TokenHistory?>(
                  valueListenable: _prices,
                  builder: (context, history, _) {
                    if (history == null) {
                      return const CircularProgressIndicator();
                    }

                    final prices = history.prices.map((p) => p.value).toList()
                      ..sort();
                    final priceMax = prices.last.toDouble();
                    final priceMin = prices.first.toDouble();

                    return Chart(
                      duration: const Duration(milliseconds: 250),
                      layers: [
                        ChartHighlightLayer(
                          shape: () =>
                              ChartHighlightLineShape<ChartLineDataItem>(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.48),
                            currentPos: (item) => item.currentValuePos,
                            radius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            width: 30,
                          ),
                        ),
                        ChartAxisLayer(
                          settings: ChartAxisSettings(
                            x: ChartAxisSettingsAxis(
                              frequency: _frequency,
                              max: _dateTo.millisecondsSinceEpoch.toDouble(),
                              min: _dateFrom.millisecondsSinceEpoch.toDouble(),
                              textStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10.0,
                              ),
                            ),
                            y: ChartAxisSettingsAxis(
                              frequency: (priceMax - priceMin) / 5,
                              max: priceMax,
                              min: priceMin,
                              textStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          labelX: (val) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                              val.toInt(),
                            );
                            if (date.difference(DateTime.now()).inHours.abs() >=
                                48) {
                              return DateFormat(
                                context.localizations.dateFormat,
                              ).format(date);
                            }
                            return timeago.format(date);
                          },
                          labelY: (val) =>
                              NumberFormat.compactCurrency(symbol: '€')
                                  .format(val),
                        ),
                        ChartGridLayer(
                          settings: ChartGridSettings(
                            x: ChartGridSettingsAxis(
                              color: Theme.of(context).colorScheme.onBackground,
                              frequency: (priceMax - priceMin) / 5,
                              max: priceMax,
                              min: priceMin,
                              thickness: .3,
                            ),
                            y: ChartGridSettingsAxis(
                              color: Theme.of(context).colorScheme.onBackground,
                              frequency: (priceMax - priceMin) / 5,
                              max: priceMax,
                              min: priceMin,
                              thickness: .3,
                            ),
                          ),
                        ),
                        ChartLineLayer(
                          items: history.prices
                              .map(
                                (p) => ChartLineDataItem(
                                  x: p.day.toDouble(),
                                  value: p.value.toDouble(),
                                ),
                              )
                              .toList(),
                          settings: ChartLineSettings(
                            color: Theme.of(context).colorScheme.primary,
                            thickness: 2.0,
                          ),
                        ),
                        ChartTooltipLayer(
                          shape: () => ChartTooltipLineShape<ChartLineDataItem>(
                            backgroundColor: Colors.white,
                            circleBackgroundColor: Colors.white,
                            circleBorderColor:
                                Theme.of(context).colorScheme.primary,
                            circleSize: 4.0,
                            circleBorderThickness: 2.0,
                            currentPos: (item) => item.currentValuePos,
                            onTextValue: (item) => NumberFormat.compactCurrency(
                              symbol: '€',
                            ).format(item.value),
                            marginBottom: 6.0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                            radius: 6.0,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 0.2,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                            triangleSideLength: 12,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    ValueListenableBuilder<int?>(
                      valueListenable: _lastHours,
                      builder: (context, value, _) {
                        final dateFormat = DateFormat(
                          'dd/MM/yyyy HH:mm',
                        );
                        return ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.priceChange(
                              dateFormat.format(_dateFrom),
                              dateFormat.format(_dateTo),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          subtitle: ValueListenableBuilder<TokenHistory?>(
                            valueListenable: _prices,
                            builder: (context, value, child) {
                              if (value == null) return child!;
                              return Text(
                                NumberFormat.simpleCurrency().format(_variance),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: _variance >= 0
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                              );
                            },
                            child: const Center(
                              child: LinearProgressIndicator(),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final localizations =
                                  AppLocalizations.of(context)!;
                              final rangeChosen = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(1970),
                                lastDate: DateTime.now(),
                                currentDate: _dateTo,
                                initialDateRange: DateTimeRange(
                                  start: _dateFrom,
                                  end: _dateTo,
                                ),
                              );

                              if (rangeChosen == null) return;

                              final dateFromTime = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 0, minute: 0),
                                    helpText: localizations.timeStartHelp,
                                  ) ??
                                  const TimeOfDay(hour: 0, minute: 0);

                              final dateToTime = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 0, minute: 0),
                                    helpText: localizations.timeEndHelp,
                                  ) ??
                                  const TimeOfDay(hour: 0, minute: 0);

                              _dateFrom = DateTime(
                                rangeChosen.start.year,
                                rangeChosen.start.month,
                                rangeChosen.start.day,
                                dateFromTime.hour,
                                dateFromTime.minute,
                              );
                              _dateTo = DateTime(
                                rangeChosen.end.year,
                                rangeChosen.end.month,
                                rangeChosen.end.day,
                                dateToTime.hour,
                                dateToTime.minute,
                              );
                              _prices.value = null;
                              _lastHours.value =
                                  _dateFrom.difference(_dateTo).inHours;
                            },
                            icon: const Icon(FontAwesomeIcons.clockRotateLeft),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<TokenHistory?>(
                      valueListenable: _prices,
                      builder: (context, value, _) {
                        if (value == null) return Container();
                        return ListTile(
                          title: Text(
                            context.localizations.lblSinceLastPurchase,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          subtitle: Text(
                            NumberFormat.simpleCurrency()
                                .format(num.parse(widget.price24h)),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.green),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          child: Text(context.localizations.btnPurchase),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
