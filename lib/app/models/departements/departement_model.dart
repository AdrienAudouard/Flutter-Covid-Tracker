import 'package:covid_tracker/app/models/departements/departements_stats.dart';

class DepartementModel {
  final String name;
  final String number;
  final String region;

  DepartementStats? stats;

  DepartementModel.fromJson(Map<String, dynamic> parsedJson):
      name = parsedJson['dep_name'],
      number = parsedJson['num_dep'].toString(),
      region = parsedJson['region_name'];

  @override
  String toString() {
    return 'DepartementModel{name: $name, number: $number, region: $region, stats: $stats}';
  }
}