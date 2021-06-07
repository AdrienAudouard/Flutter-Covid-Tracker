import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/vaccine/daily_vaccine_model.dart';
import 'package:http/http.dart' as http;

class DailyVaccineFranceProvider {
  Future<DailyVaccineFranceModel> fetchDailyVaccine() async {
    final uri = Uri.parse(env.vaccinFranceStat);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DailyVaccineFranceModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}