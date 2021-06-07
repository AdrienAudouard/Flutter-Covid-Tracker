import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/departements/departements_stats.dart';
import 'package:http/http.dart' as http;

class DepartementStatProvider {
  Future<DepartementsStats> fetchDepartementsStat() async {
    final uri = Uri.parse(env.departementStatsUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Fix API bug in the response, NaN provided instead of a number
      final encodedBody = utf8.encode(response.body.replaceAll('NaN', '0'));
      return DepartementsStats.fromJson(json.decode(utf8.decode(encodedBody)));
    } else {
      throw Exception('Failed to load post');
    }
  }
}