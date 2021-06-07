import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/daily_stats/actual_positive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ActualPositiveProvider {
  final Client client = Client();

  Future<ActualPositive> fetchActualPositive() async {
    final todayUri = Uri.parse(env.todayStatUrl);
    final lastWeekUri = Uri.parse(env.lastWeekUrl);

    final todayResponse = await client.get(todayUri);
    final lastWeekResponse = await client.get(lastWeekUri);

    if (todayResponse.statusCode == 200 && lastWeekResponse.statusCode == 200) {
      return ActualPositive.fromJson(jsonDecode(todayResponse.body), jsonDecode(lastWeekResponse.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}