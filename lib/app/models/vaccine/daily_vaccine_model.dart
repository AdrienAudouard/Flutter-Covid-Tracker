import 'package:covid_tracker/app/utils/const.dart';

class DailyVaccineFranceModel {
  final List<String> dates;
  final List<num> fullyVaccinated;
  final List<num> fullyVaccinatedCumulated;
  final List<num> fullyVaccinatedSevenDaysAverage;
  final List<num> firstDose;
  final List<num> firstDoseCumulated;
  final List<num> firstDoseSevenDaysAverage;

  DailyVaccineFranceModel.fromJson(Map<String, dynamic> parsedJson):
      dates = parsedJson['dates'].cast<num>().cast<String>(),
      fullyVaccinated = parsedJson['n_complet'].cast<num>(),
      fullyVaccinatedSevenDaysAverage = parsedJson['n_complet_moyenne7j'].cast<num>(),
      fullyVaccinatedCumulated = parsedJson['n_cum_complet'].cast<num>(),
      firstDoseCumulated = parsedJson['n_cum_dose1'].cast<num>(),
      firstDose = parsedJson['n_dose1'].cast<num>(),
      firstDoseSevenDaysAverage = parsedJson['n_dose1_moyenne7j'].cast<num>();

  double get fullyVaccinatedPercent {
    return fullyVaccinatedCumulated.last / frenchPopulation * 100;
  }

  double get fullyVaccinatedPercentRatio {
    return fullyVaccinatedCumulated.last / frenchPopulation;
  }

  double get singleDosePercentVaccinatedRatio {
    return firstDoseCumulated.last / frenchPopulation;
  }

  double get singleDosePercentVaccinated {
    return firstDoseCumulated.last / frenchPopulation * 100;
  }
}