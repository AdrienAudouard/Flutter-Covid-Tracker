import 'dart:async';
import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/daily_stats/main_stats_model.dart';
import 'package:http/http.dart' as http;

class StatProvider {
  Future<MainStatsModel> fetchStat() async {
    final uri = Uri.parse(env.statsUrl);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return MainStatsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}