import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/daily_stats/daily_cases_model.dart';
import 'package:http/http.dart' as http;

class DailyCasesProvider {
  Future<DailyCasesModel> fetchDailyCases() async {
    final uri = Uri.parse(env.dailyCasesUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DailyCasesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}