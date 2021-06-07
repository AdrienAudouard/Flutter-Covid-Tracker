import 'package:covid_tracker/app/utils/utils_func.dart';

class MainStatsModel {
  final _Taux positivite;
  final _Taux incidence;
  final _Taux saturationRea;
  final _Taux reffectif;
  final _DateValue newHospitalisation;
  final _DateValue newReanimation;
  final _DateValue deces;

  MainStatsModel.fromJson(Map<String, dynamic> parsedJson) :
    positivite = _Taux.fromJson(parsedJson['taux_positivite']),
    incidence = _Taux.fromJson(parsedJson['taux_incidence']),
    saturationRea = _Taux.fromJson(parsedJson['taux_saturation_rea']),
    reffectif = _Taux.fromJson(parsedJson['reffectif']),
    newHospitalisation = _DateValue.fromJson(parsedJson['hosp_new']),
    newReanimation = _DateValue.fromJson(parsedJson['rea_new']),
    deces = _DateValue.fromJson(parsedJson['incid_dc']);
}

class _DateValue {
  final String date;
  final double value;

  _DateValue(this.date, this.value);

  _DateValue.fromJson(Map<String, dynamic> parsedJson) :
    date = parsedJson['date'],
    value = parseDouble(parsedJson['valeur']);
}

class _Taux {
  final String _label;
  final double _value;

  _Taux(this._label, this._value);

  String get label => _label;

  double get value => _value;

  _Taux.fromJson(Map<String, dynamic> parsedJson):
    _label = parsedJson['str'],
    _value = parseDouble(parsedJson['valeur']);
}