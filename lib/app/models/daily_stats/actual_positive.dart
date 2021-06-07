class ActualPositive {
  final _Data today;
  final _Data lastWeek;
  final double evolution;

  ActualPositive(this.today, this.lastWeek, this.evolution);

  factory ActualPositive.fromJson(Map<String, dynamic> todayJson, Map<String, dynamic> lastWeekJson) {
    final today = _Data.fromJson(todayJson);
    final lastWeek = _Data.fromJson(lastWeekJson);
    final evolution = (today.cas / lastWeek.cas - 1) * 100;

    return ActualPositive(today, lastWeek, evolution);
  }
}

class _Data {
  final int cas;
  final String date;

  _Data.fromJson(Map<String, dynamic> parsedJson):
      cas = parsedJson['cas'] as int,
      date = parsedJson['update'] as String;
}