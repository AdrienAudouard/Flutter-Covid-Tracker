import 'package:covid_tracker/app/models/daily_stats/main_stats_model.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/indicators_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Indicators extends StatelessWidget {
  final MainStatsModel _mainStat;

  const Indicators(this._mainStat);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IndicatorsItem(AppLocalizations.of(context)!.pageCovidIncidence, _mainStat.incidence.value, _mainStat.incidence.label),
        IndicatorsItem(AppLocalizations.of(context)!.pageCovidPositivity, _mainStat.positivite.value, _mainStat.positivite.label, '%'),
        IndicatorsItem(AppLocalizations.of(context)!.pageCovidReproduction, _mainStat.reffectif.value, _mainStat.positivite.label)
      ],
    );
  }
}