class TokenPrice {
  final DateTime date;
  final double value;

  TokenPrice({required this.date, required this.value});

  double get relativeDate {
    final date = DateTime.now();
    return this.date.difference(date).inMinutes * 1.0;
  }
}

class TokenPriceHistory {
  final String token;
  final List<TokenPrice> history;

  TokenPriceHistory({required this.token, required this.history});

  List<double> get _sortedValues =>
      (history.map((h) => h.value).toList()..sort());

  List<double> get _sortedDates =>
      (history.map((h) => h.relativeDate).toList()..sort());

  double get minValue {
    final vals = _sortedValues;
    if (vals.isEmpty) return 0;
    return vals.first;
  }

  double get maxValue {
    final vals = _sortedValues;
    if (vals.isEmpty) return 0;
    return vals.last;
  }

  double get minDate {
    final vals = _sortedDates;
    if (vals.isEmpty) return 0;
    return vals.first;
  }

  double get maxDate {
    final vals = _sortedDates;
    if (vals.isEmpty) return 0;
    return vals.last;
  }
}
