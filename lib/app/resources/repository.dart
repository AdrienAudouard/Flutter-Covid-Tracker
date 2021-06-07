import 'package:covid_tracker/app/models/daily_stats/covid_data.dart';
import 'package:covid_tracker/app/models/vaccine/daily_vaccine_model.dart';
import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:covid_tracker/app/models/departements/departements_stats.dart';
import 'package:covid_tracker/app/resources/providers/daily_stats/actual_positive_provider.dart';
import 'package:covid_tracker/app/resources/providers/vaccine/daily_cases_provider.dart';
import 'package:covid_tracker/app/resources/providers/vaccine/daily_vaccine_france_provider.dart';
import 'package:covid_tracker/app/resources/providers/departements/departement_stats_provider.dart';
import 'package:covid_tracker/app/resources/providers/departements/departements_provider.dart';
import 'package:covid_tracker/app/resources/providers/stat_provider.dart';

class Repository {
  final _statProvider = StatProvider();
  final _positiveProvider = ActualPositiveProvider();
  final _dailyCasesProvider = DailyCasesProvider();
  final _departementProvider = DepartementsProvider();
  final _departementsStatProvider = DepartementStatProvider();
  final _dailyVaccineFranceProvider = DailyVaccineFranceProvider();

  Future<CovidData> fetchTodayData() async {
    final actualPositive = await _positiveProvider.fetchActualPositive();
    final stat = await _statProvider.fetchStat();
    final dailyCases = await _dailyCasesProvider.fetchDailyCases();

    return CovidData(actualPositive, stat, dailyCases);
  }

  Future<List<DepartementModel>> fetchDepartementList() {
    return _departementProvider.fetchDepartements();
  }

  Future<DepartementsStats> fetchDepartementsStats() {
    return _departementsStatProvider.fetchDepartementsStat();
  }

  Future<DailyVaccineFranceModel> fetchDailyVaccineFrance() {
    return _dailyVaccineFranceProvider.fetchDailyVaccine();
  }
}