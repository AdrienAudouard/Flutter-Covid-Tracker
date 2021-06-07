import 'package:covid_tracker/app/models/vaccine/daily_vaccine_model.dart';
import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:covid_tracker/app/utils/const.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstDose extends StatelessWidget {
  final DailyVaccineFranceModel dailyVaccineFrance;

  const FirstDose(this.dailyVaccineFrance);

  @override
  Widget build(BuildContext context) {
    final totalVaccinated =
        numberFormat.format(dailyVaccineFrance.firstDoseCumulated.last);
    final last24 = numberFormat.format(dailyVaccineFrance.firstDose.last);
    final average =
        numberFormat.format(dailyVaccineFrance.firstDoseSevenDaysAverage.last);

    return CtCard(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            AppLocalizations.of(context)!
                .pageVaccineTotalFirstDose(totalVaccinated),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        getSizedBox(height: 1),
        Text(AppLocalizations.of(context)!.pageVaccineTotalFirstDoseExplanation,
            style: Theme.of(context).textTheme.subtitle1),
        getSizedBox(height: 1),
        Text(AppLocalizations.of(context)!.pageVaccineTotalFirstDosePercent(
            dailyVaccineFrance.singleDosePercentVaccinated.toStringAsFixed(2))),
        getSizedBox(height: 1),
        LinearProgressIndicator(
          minHeight: 8,
          backgroundColor: HexColor('#45526c'),
          color: HexColor('#5aa897'),
          value: dailyVaccineFrance.singleDosePercentVaccinatedRatio,
        ),
        const Divider(
          height: 30,
          thickness: 1,
        ),
        Text(AppLocalizations.of(context)!.pageVaccineTotalFirstDoseLast24h(last24),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        getSizedBox(height: 1),
        Text(AppLocalizations.of(context)!.pageVaccine7DaysAverage(average))
      ],
    ));
  }
}
