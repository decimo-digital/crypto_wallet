import 'package:timeago/timeago.dart';

class ShortLookupItMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => 'tra';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'ora';
  @override
  String aboutAMinute(int minutes) => 'poco fa';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => "un'ora";
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => 'ieri';
  @override
  String days(int days) => '${days}gg';
  @override
  String aboutAMonth(int days) => 'un mese';
  @override
  String months(int months) => '${months}M';
  @override
  String aboutAYear(int year) => 'un anno';
  @override
  String years(int years) => '${years}a';
  @override
  String wordSeparator() => ' ';
}
