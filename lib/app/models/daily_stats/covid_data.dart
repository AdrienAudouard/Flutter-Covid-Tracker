import 'package:covid_tracker/app/models/daily_stats/daily_cases_model.dart';

import 'actual_positive.dart';
import 'main_stats_model.dart';

class CovidData {
  final ActualPositive actualPositive;
  final MainStatsModel mainData;
  final DailyCasesModel dailyCases;

  CovidData(this.actualPositive, this.mainData, this.dailyCases);
}