class _Env {
  final String departementListUrl = 'https://www.data.gouv.fr/fr/datasets/r/7b4bc207-4e66-49d2-b1a5-26653e369b66';
  final String baseCovidUrl = 'https://raw.githubusercontent.com/rozierguillaume/covid-19/master/data/france/stats';
  final String baseVaccinUrl = 'https://raw.githubusercontent.com/rozierguillaume/vaccintracker/main/data/output';

  String get todayStatUrl {
    return '$baseCovidUrl/vue-ensemble.json';
  }

  String get lastWeekUrl {
    return '$baseCovidUrl/cas_sidep.json';
  }

  String get dailyCasesUrl {
    return '$baseCovidUrl/objectif_deconfinement.json';
  }

  String get statsUrl {
    return '$baseCovidUrl/stats.json';
  }

  String get departementStatsUrl {
    return '$baseCovidUrl/incidence_departements.json';
  }

  String get vaccinFranceStat {
    return '$baseVaccinUrl/vacsi-fra.json';
  }
}

final env = _Env();