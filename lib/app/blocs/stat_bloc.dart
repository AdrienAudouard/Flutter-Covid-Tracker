import 'package:covid_tracker/app/models/daily_stats/covid_data.dart';
import 'package:covid_tracker/app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StatBloc {
  final _repository = Repository();
  final _statFetcher = BehaviorSubject<CovidData>();

  Stream<CovidData> get mainStats => _statFetcher.stream;

  void fetchStat() {
    if (!_statFetcher.hasValue) {
      _repository.fetchTodayData().then((value) => _statFetcher.add(value));
    }
  }

  void dispose() {
    _statFetcher.close();
  }
}

final statBloc = StatBloc();