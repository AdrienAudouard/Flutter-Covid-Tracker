import 'package:covid_tracker/app/models/departements/departements_stats.dart';
import 'package:covid_tracker/app/ui/departements/widgets/variant_chart.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Variant extends StatelessWidget {
  final DepartementStats stat;

  const Variant(this.stat);

  @override
  Widget build(BuildContext context) {
    return CtCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.pageDepartementVariantRepartition, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          VariantChart(stat.variantUk, stat.variantBz, stat.otherVariants)
        ],
      )
    );
  }

}