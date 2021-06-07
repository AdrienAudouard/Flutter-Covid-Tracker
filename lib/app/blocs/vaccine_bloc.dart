import 'package:covid_tracker/app/models/vaccine/daily_vaccine_model.dart';
import 'package:covid_tracker/app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class VaccineBloc {
  final _repository = Repository();
  final _vaccineFetcher = BehaviorSubject<DailyVaccineFranceModel>();

  Stream<DailyVaccineFranceModel> get franceVaccine => _vaccineFetcher.stream;

  void fetchStat() {
    if (!_vaccineFetcher.hasValue) {
      _repository.fetchDailyVaccineFrance().then((value) => _vaccineFetcher.add(value));
    }
  }

  void dispose() {
    _vaccineFetcher.close();
  }
}

final vaccineBloc = VaccineBloc();