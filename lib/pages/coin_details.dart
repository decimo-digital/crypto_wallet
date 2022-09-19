import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:timeago/timeago.dart' as timeago;

class CoinDetails extends StatefulWidget {
  const CoinDetails({
    required this.coinId,
    super.key,
  });

  final String coinId;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails> {
  late DateTime _dateFrom;
  late DateTime _dateTo;
  late double _frequency;

  @override
  void initState() {
    super.initState();
    _dateTo = DateTime.now();
    _dateFrom = _dateTo.subtract(const Duration(days: 3));
    _frequency =
        (_dateTo.millisecondsSinceEpoch - _dateFrom.millisecondsSinceEpoch) /
            5.0;
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
                child: Chart(
                  duration: const Duration(milliseconds: 250),
                  layers: [
                    ChartHighlightLayer(
                      shape: () => ChartHighlightLineShape<ChartLineDataItem>(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.48),
                        currentPos: (item) => item.currentValuePos,
                        radius: const BorderRadius.all(Radius.circular(8.0)),
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
                          frequency: 100.0,
                          max: 400.0,
                          min: 0.0,
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
                          return DateFormat('dd/MM').format(date);
                        }
                        return timeago.format(date, locale: 'it');
                      },
                      labelY: (val) => NumberFormat.compactCurrency(
                        locale: 'it',
                        symbol: '€',
                      ).format(val),
                    ),
                    ChartGridLayer(
                      settings: ChartGridSettings(
                        x: ChartGridSettingsAxis(
                          color: Theme.of(context).colorScheme.onBackground,
                          frequency: 10,
                          max: 100,
                          min: 0,
                          thickness: .3,
                        ),
                        y: ChartGridSettingsAxis(
                          color: Theme.of(context).colorScheme.onBackground,
                          frequency: 1,
                          max: 10,
                          min: 0,
                          thickness: .3,
                        ),
                      ),
                    ),
                    ChartLineLayer(
                      items: List.generate(
                        4,
                        (index) => ChartLineDataItem(
                          x: _dateFrom
                                  .add(Duration(days: index))
                                  .millisecondsSinceEpoch *
                              1.0,
                          value: Random().nextInt(380) + 20,
                        ),
                      ),
                      settings: ChartLineSettings(
                        color: Theme.of(context).colorScheme.primary,
                        thickness: 4.0,
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
                          locale: 'it',
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
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'In last 10 hours',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      subtitle: Text(
                        '€ 2500 (+ 50%)',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.green,
                            ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.clockRotateLeft),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Since last purchase',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      subtitle: Text(
                        '+ 350 (+ 5%)',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.green,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          child: const Text('Purchase'),
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
