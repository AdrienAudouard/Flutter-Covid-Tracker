import 'dart:convert';

import 'package:covid_tracker/app/config/env.dart';
import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:http/http.dart' as http;

class DepartementsProvider {
  Future<List<DepartementModel>> fetchDepartements() async {
    final uri = Uri.parse(env.departementListUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final list = json.decode(utf8.decode(response.bodyBytes));
      return List<DepartementModel>.from(list.map((model)=> DepartementModel.fromJson(model)));
    } else {
      throw Exception('Failed to load post');
    }
  }
}