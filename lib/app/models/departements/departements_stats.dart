class DepartementsStats {
  final Map<String, DepartementStats> donneesDepartements;
  final String lastUpdated;

  DepartementsStats(this.donneesDepartements, this.lastUpdated);

  factory DepartementsStats.fromJson(Map<String, dynamic> parsedJson) {
    final rawDepartement = parsedJson['donnees_departements'] as Map<String, dynamic>;
    final departements = <String, DepartementStats>{};

    rawDepartement
        .entries
        .forEach((it) {
          departements[it.key.toLowerCase()] = DepartementStats.fromJson(it.value);
    });

    return DepartementsStats(departements, parsedJson['date_update']);
  }
}

class DepartementStats {
  final int incidence;
  final num positivity;
  final num hospitalSaturation;
  final double variantBz;
  final double variantUk;

  DepartementStats.fromJson(Map<String, dynamic> parsedJson) :
        hospitalSaturation = parsedJson['saturation_rea'],
        variantBz = parsedJson['var_sa_bz'],
        variantUk = parsedJson['var_uk'],
        positivity = parsedJson['taux_positivite'],
        incidence = parsedJson['incidence_cas'];

  @override
  String toString() {
    return 'DepartementStats{incidence: $incidence}';
  }

  double get otherVariants {
    return 100 - variantUk - variantBz;
  }
}