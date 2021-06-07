import 'package:covid_tracker/app/models/daily_stats/covid_data.dart';
import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/data_item.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Hospital extends StatelessWidget {
  final CovidData todayData;

  const Hospital(this.todayData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DataItem(
                AppLocalizations.of(context)!.pageCovidHospital,
                todayData.mainData.newHospitalisation.value,
                getValueColor(todayData.mainData.newHospitalisation.value)
            ),
            DataItem(
                AppLocalizations.of(context)!.pageCovidRea,
                todayData.mainData.newReanimation.value,
                getValueColor(todayData.mainData.newReanimation.value)
            ),
          ],
        ),
        getSizedBox(height: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DataItem(
              AppLocalizations.of(context)!.pageCovidDeaths,
                todayData.mainData.deces.value,
                getValueColor(todayData.mainData.deces.value),
                valuePrefix: '+',
            ),
            DataItem(
                AppLocalizations.of(context)!.pageCovidSaturation,
                todayData.mainData.saturationRea.value,
                getSaturationColor(),
                valueSuffix: '%'
            )
          ],
        )
      ],
    );
  }

  HexColor getSaturationColor() {
    final value = todayData.mainData.saturationRea.value;

    if (value > 80) {
      return AppColors.red;
    } else if (value < 40) {
      return AppColors.green;
    } else {
      return AppColors.orange;
    }
  }
}