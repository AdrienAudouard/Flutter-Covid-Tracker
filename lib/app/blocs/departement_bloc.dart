import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:covid_tracker/app/models/departements/departements_stats.dart';
import 'package:covid_tracker/app/resources/providers/daily_stats/preferences_provider.dart';
import 'package:covid_tracker/app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DepartementBloc {
  static const String _saveDepartementKey = "_saveDepartementKey";

  final Repository _repository = Repository();
  final BehaviorSubject<List<DepartementModel>> _departementList = BehaviorSubject();
  final BehaviorSubject<DepartementModel> _selectedDepartement = BehaviorSubject();
  final PreferencesProvider _preferencesProvider = PreferencesProvider();

  Stream<List<DepartementModel>> get departementList => _departementList.stream;
  Stream<DepartementModel> get selectedDepartement => _selectedDepartement.stream;
  String? lastUpdated;

  void fetchDepartementList() {
    if (!_departementList.hasValue) {
      _fetchDepartementList();
    }
  }

  void _fetchDepartementList() {
    Future.wait([
      _repository.fetchDepartementList(),
      _repository.fetchDepartementsStats()
    ]).then((responses) {
      final departementList = responses[0] as List<DepartementModel>;
      final departementsStat = responses[1] as DepartementsStats;

      lastUpdated = departementsStat.lastUpdated;

      for (final departement in departementList) {
        departement.stats = departementsStat.donneesDepartements[departement.name.toLowerCase()];
      }

      _departementList.add(departementList);
      setDefaultSelectedDepartement(departementList);
    });
  }

  void setDefaultSelectedDepartement(List<DepartementModel> departements) {
    final saveDepartement = _preferencesProvider.getString(_saveDepartementKey) ?? departements[0].number;

    setSelectedDepartement(saveDepartement);
  }

  void setSelectedDepartement(String number) {
    final departement = _departementList.valueOrNull!.firstWhere((element) => element.number == number);
    _selectedDepartement.add(departement);
    _preferencesProvider.saveString(_saveDepartementKey, number);
  }
}

final departementBloc = DepartementBloc();