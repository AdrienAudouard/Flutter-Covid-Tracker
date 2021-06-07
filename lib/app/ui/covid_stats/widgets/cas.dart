import 'package:covid_tracker/app/models/daily_stats/covid_data.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'data_item.dart';

class Cas extends StatelessWidget {
  final CovidData todayData;

  const Cas(this.todayData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DataItem(AppLocalizations.of(context)!.pageCovidPositivity,
                todayData.actualPositive.today.cas, AppColors.green),
            getSizedBox(height: 1),
            DataItem(
                AppLocalizations.of(context)!.pageCovidSinceLastWeek,
                todayData.dailyCases.lastSevenDaysEvolution,
                getValueColor(todayData.dailyCases.lastSevenDaysEvolution),
                valueSuffix: '%'
            )
          ],
        ),
      ],
    );
  }
}
