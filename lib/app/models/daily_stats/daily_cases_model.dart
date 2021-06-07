class DailyCasesModel {
  final DailyValues cas;
  final DailyValues reanimation;
  
  DailyCasesModel.fromJson(Map<String, dynamic> parsedJson) :
        cas = DailyValues.fromJson(parsedJson['cas']),
        reanimation = DailyValues.fromJson(parsedJson['rea']);

  double get lastSevenDaysEvolution {
    final reversed = cas.values.reversed.toList();

    final thisWeek = reversed.getRange(0, 7).reduce((a, b) => a + b) / 7;
    final lastWeek = reversed.getRange(7, 14).reduce((a, b) => a + b) / 7;

    return (1 - lastWeek / thisWeek) * 100;
  }
}

class DailyValues {
  final List<String> dates;
  final List<int> values;

  DailyValues.fromJson(Map<String, dynamic> parsedJson) :
        dates = parsedJson['dates'].cast<String>(),
        values = parsedJson['values'].cast<int>();
}