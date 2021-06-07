import 'package:covid_tracker/app/models/departements/departements_stats.dart';
import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaturationHospitalCard extends StatelessWidget {
  final DepartementStats stats;

  const SaturationHospitalCard(this.stats);

  @override
  Widget build(BuildContext context) {
    final saturationColor = getValueColor();

    return CtCard(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(text: AppLocalizations.of(context)!.pageDepartementHospitalTension),
                      TextSpan(
                          text: '${stats.hospitalSaturation.toStringAsFixed(0)}%',
                          style: TextStyle(color: saturationColor)
                      ),
                    ]
                )
            ),
            getSizedBox(height: 1),
            LinearProgressIndicator(
              minHeight: 8,
              backgroundColor: HexColor('#45526c'),
              color: saturationColor,
              value: stats.hospitalSaturation.toDouble() / 100,
            ),
            getSizedBox(height: 1),
            Text(AppLocalizations.of(context)!.pageDepartementHospitalTensionDisclaimer, style: Theme.of(context).textTheme.subtitle1),
          ],
        )
    );
  }

  HexColor getValueColor() {
    if (stats.hospitalSaturation >= 80) {
      return AppColors.red;
    } else if (stats.hospitalSaturation >= 30) {
        return AppColors.orange;
    } else {
      return AppColors.green;
    }
  }

}